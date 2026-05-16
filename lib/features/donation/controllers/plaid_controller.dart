import 'dart:async';

import 'package:cresent_charge_user_app/features/donation/controllers/bank_connect_controller.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/create_plaid_link_token_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plaid_flutter/plaid_flutter.dart';

/// Reusable Plaid Link Controller
///
/// Handles Plaid Link integration including:
/// - Creating link token configuration
/// - Opening Plaid Link UI
/// - Managing link events, success, and exit callbacks
/// - Connecting bank accounts after successful link
class PlaidController extends GetxController {
  final createPlaidTokenCtrl = Get.put(CreatePlaidLinkToken());
  final bankConnectionController = Get.put(BankConnectionController());

  LinkTokenConfiguration? _configuration;
  StreamSubscription<LinkEvent>? _streamEvent;
  StreamSubscription<LinkExit>? _streamExit;
  StreamSubscription<LinkSuccess>? _streamSuccess;
  StreamSubscription<LinkOnLoad>? _streamOnLoad;

  final RxBool isLoadingConfiguration = false.obs;
  LinkObject? _successObject;

  LinkTokenConfiguration? get configuration => _configuration;
  LinkObject? get successObject => _successObject;

  // Callbacks for custom handling
  Function(LinkSuccess)? onSuccessCallback;
  Function(LinkExit)? onExitCallback;
  Function(LinkEvent)? onEventCallback;

  @override
  void onInit() {
    super.onInit();
    _streamEvent = PlaidLink.onEvent.listen(_onEvent);
    _streamExit = PlaidLink.onExit.listen(_onExit);
    _streamSuccess = PlaidLink.onSuccess.listen( _onSuccess );
    _streamOnLoad = PlaidLink.onLoad.listen( _onLoad );
  }

  @override
  void dispose() {
    _streamEvent?.cancel();
    _streamExit?.cancel();
    _streamSuccess?.cancel();
    _streamOnLoad?.cancel();
    super.dispose();
  }

  /// Open Plaid Link UI
  Future<void> openLink() async {
    if (_configuration == null) {
      debugPrint("Configuration is null, please create it first.");
      return;
    }

    try {
      _configuration = null;
      update();
      await PlaidLink.open();
    } catch (e) {
      debugPrint("Error opening Link: $e");
    }
  }

  /// Create Plaid Link Token Configuration and open link
  Future<void> createLinkTokenConfiguration() async {
    final bool isSuccess = await createPlaidTokenCtrl.generateLinkToken();
    if (!isSuccess) {
      debugPrint("Failed to generate link token");
      return;
    }

    final LinkTokenConfiguration configuration = LinkTokenConfiguration(
      token: createPlaidTokenCtrl.linkToken,
    );

    isLoadingConfiguration.value = true;
    await PlaidLink.create(configuration: configuration);

    isLoadingConfiguration.value = false;
    _configuration = configuration;
    update();

    await openLink();
  }

  void _onLoad(_) {
    debugPrint("LinkTokenConfiguration Loaded");
  }

  void _onEvent(LinkEvent event) {
    final name = event.name;
    final metadata = event.metadata.description();
    debugPrint("onEvent: $name, metadata: $metadata");

    onEventCallback?.call(event);
  }

  void _onSuccess(LinkSuccess event) async {

    final token = event.publicToken;
    final metadata = event.metadata.description();
    debugPrint("onSuccess: $token, metadata: $metadata");
    _successObject = event;

    // Connect bank account with public token
    await bankConnectionController.connectBank(token);

    // Call custom callback if provided
    onSuccessCallback?.call(event);
    update();
  }

  void _onExit(LinkExit event) {
    final metadata = event.metadata.description();
    final error = event.error?.description();
    debugPrint("onExit metadata: $metadata, error: $error");

    // Call custom callback if provided
    onExitCallback?.call(event);

    update();
  }

  /// Reset callbacks
  void clearCallbacks() {
    onSuccessCallback = null;
    onExitCallback = null;
    onEventCallback = null;
  }
}

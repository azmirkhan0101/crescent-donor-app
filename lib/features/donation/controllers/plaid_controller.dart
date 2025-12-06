// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:plaid_flutter/plaid_flutter.dart';

// class PlaidController extends GetxController {
//   LinkTokenConfiguration? _configuration;
//   StreamSubscription<LinkEvent>? _streamEvent;
//   StreamSubscription<LinkExit>? _streamExit;
//   StreamSubscription<LinkSuccess>? _streamSuccess;
//   StreamSubscription<LinkOnLoad>? _streamOnLoad;

//   LinkObject? _successObject;
//   bool _isLoadingConfiguration = false;

//   LinkTokenConfiguration? get configuration => _configuration;
//   LinkObject? get successObject => _successObject;
//   bool get isLoadingConfiguration => _isLoadingConfiguration;

//   @override
//   void onInit() {
//     super.onInit();
//     _streamEvent = PlaidLink.onEvent.listen(_onEvent);
//     _streamExit = PlaidLink.onExit.listen(_onExit);
//     _streamSuccess = PlaidLink.onSuccess.listen(_onSuccess);
//     _streamOnLoad = PlaidLink.onLoad.listen(_onLoad);
//   }

//   @override
//   void dispose() {
//     _streamEvent?.cancel();
//     _streamExit?.cancel();
//     _streamSuccess?.cancel();
//     _streamOnLoad?.cancel();
//     super.dispose();
//   }

//   void openLink() async {
//     if (_configuration == null) {
//       debugPrint("Configuration is null, please create it first.");
//       return;
//     }

//     try {
//       _configuration = null;
//       update();
//       await PlaidLink.open();
//     } catch (e) {
//       debugPrint("Error opening Link: $e");
//     }
//   }

//   void createLinkTokenConfiguration(String token) async {
//     LinkTokenConfiguration configuration = LinkTokenConfiguration(
//       token: token, // Replace with your actual link token
//     );
//     _isLoadingConfiguration = true;
//     update();

//     await PlaidLink.create(configuration: configuration);

//     _isLoadingConfiguration = false;
//     _configuration = configuration;
//     update();
//     openLink();
//   }

//   void _onLoad(_) {
//     debugPrint("LinkTokenConfiguration Loaded");
//   }

//   void _onEvent(LinkEvent event) {
//     final name = event.name;
//     final metadata = event.metadata.description();
//     debugPrint("onEvent: $name, metadata: $metadata");
//     update();
//   }

//   void _onSuccess(LinkSuccess event) {
//     final token = event.publicToken;
//     final metadata = event.metadata.description();
//     debugPrint("onSuccess: $token, metadata: $metadata");
//     _successObject = event;
//     update();
//   }

//   void _onExit(LinkExit event) {
//     final metadata = event.metadata.description();
//     final error = event.error?.description();
//     debugPrint("onExit metadata: $metadata, error: $error");
//     update();
//   }
// }

import 'package:cresent_charge_user_app/core/routes/route_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class MakePaymentController extends GetxController {
  // Amount state
  final RxString _amount = ''.obs;
  String get amount => _amount.value;

  // Cursor animation state
  final RxBool _showCursor = true.obs;
  bool get showCursor => _showCursor.value;

  // Button highlight state
  final RxString _highlightedButton = ''.obs;
  String get highlightedButton => _highlightedButton.value;

  @override
  void onInit() {
    super.onInit();
    _startCursorAnimation();
  }

  void _startCursorAnimation() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!isClosed) {
        _showCursor.value = !_showCursor.value;
        _startCursorAnimation();
      }
    });
  }

  void onNumberPressed(String number) {
    // Highlight the button temporarily
    _highlightButton(number);

    // Handle number input
    if (number == '.' && _amount.value.contains('.')) return;
    if (_amount.value.contains('.') && _amount.value.split('.')[1].length >= 2)
      return;
    _amount.value += number;
  }

  void onBackspacePressed() {
    // Highlight the backspace button temporarily
    _highlightButton('⌫');

    // Handle backspace
    if (_amount.value.isNotEmpty) {
      _amount.value = _amount.value.substring(0, _amount.value.length - 1);
    }
  }

  void _highlightButton(String buttonText) {
    _highlightedButton.value = buttonText;

    // Remove highlight after 150ms for typing experience
    Future.delayed(const Duration(milliseconds: 150), () {
      if (!isClosed) {
        _highlightedButton.value = '';
      }
    });
  }

  void onContinuePressed(BuildContext context) {
    debugPrint(_amount.value);
    // if (_amount.value.isEmpty || _amount.value == '0') {
    //   Get.snackbar(
    //     'Error',
    //     'Please enter an amount',
    //     snackPosition: SnackPosition.BOTTOM,
    //     backgroundColor: Colors.red,
    //     colorText: Colors.white,
    //   );
    //   return;
    // }
    // Navigate to confirm donation page with amount
    context.pushNamed(RoutePath.confirmDonation, extra: _amount.value);
  }

  bool isButtonHighlighted(String buttonText) {
    return _highlightedButton.value == buttonText;
  }

  @override
  void onClose() {
    super.onClose();
  }
}

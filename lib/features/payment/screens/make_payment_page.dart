import 'package:cresent_charge_user_app/common-widgets/custom_app_bar.dart';
import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/make_payment_controller.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Define colors from Figma design
const Color _offBlack = Color(0xFF000C0B);
const Color _white = Color(0xFFFFFFFF);

class MakePaymentPage extends StatelessWidget {
  const MakePaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MakePaymentController());

    return Scaffold(
      backgroundColor: AppColors.lightPageBackground,
      appBar: CustomAppBar(
        title: 'Payment',
        backgroundColor: AppColors.lightPageBackground,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Organization Info
            _buildOrganizationInfo(),

            // Amount Display
            _buildAmountDisplay(controller),

            // Divider
            _buildDivider(),

            // Keypad
            Expanded(child: _buildKeypad(controller)),

            // Continue Button
            _buildContinueButton(controller, context),
          ],
        ),
      ),
    );
  }

  Widget _buildOrganizationInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.rh),
      child: Column(
        children: [
          // Organization Images
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.home.profileImage.svg(width: 56.rw, height: 56.rh),
              Transform.translate(
                offset: const Offset(-8, 0),
                child: Container(
                  width: 56.rw,
                  height: 56.rh,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    image: DecorationImage(
                      image: AssetImage(
                        Assets.home.varifiedCharitiesBlog1.path,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          16.rh.heightWidth,

          // "Donate to" text
          Text(
            'Donate to',
            style: AppTextStyles.f16W500(),
          ).color(AppColors.grayColor),
          4.rh.heightWidth,

          // Organization name
          Text(
            'Hope For Learning Foundation',
            textAlign: TextAlign.center,
            style: AppTextStyles.f20w600(),
          ).fontWeight(FontWeight.w500),
        ],
      ),
    );
  }

  Widget _buildAmountDisplay(MakePaymentController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.rh),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(
            () => Text(
              '\$${controller.amount.isEmpty ? '0' : controller.amount}',
              style: AppTextStyles.f16W500(),
            ).fontSize(48.rfs),
          ),
          Obx(
            () => controller.showCursor
                ? Container(
                    width: 2.rw,
                    height: 40.rh,
                    margin: const EdgeInsets.only(left: 4),
                    color: "#CCCCCC".hexColor,
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 311.rw,
      height: 1,
      color: AppColors.grayColor.withValues(alpha: 0.3),
      margin: const EdgeInsets.symmetric(vertical: 8),
    );
  }

  Widget _buildKeypad(MakePaymentController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.rw),
      child: Column(
        children: [
          16.rh.heightWidth,
          // Row 1: 1, 2, 3
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildKeypadButton('1', controller),
              _buildKeypadButton('2', controller),
              _buildKeypadButton('3', controller),
            ],
          ),
          // Row 2: 4, 5, 6
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildKeypadButton('4', controller),
              _buildKeypadButton('5', controller),
              _buildKeypadButton('6', controller),
            ],
          ),
          // Row 3: 7, 8, 9
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildKeypadButton('7', controller),
              _buildKeypadButton('8', controller),
              _buildKeypadButton('9', controller),
            ],
          ),
          // Row 4: ., 0, backspace
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildKeypadButton('.', controller),
              _buildKeypadButton('0', controller),
              _buildKeypadButton('⌫', controller, isBackspace: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKeypadButton(
    String text,
    MakePaymentController controller, {
    bool isBackspace = false,
  }) {
    return Obx(() {
      final isHighlighted = controller.isButtonHighlighted(text);

      return GestureDetector(
        onTap: () {
          if (isBackspace) {
            controller.onBackspacePressed();
          } else {
            controller.onNumberPressed(text);
          }
        },
        child: Container(
          width: 72.rw,
          height: 72.rh,
          decoration: BoxDecoration(
            color: isHighlighted ? _white : Colors.transparent,
            borderRadius: BorderRadius.circular(isHighlighted ? 99 : 16),
          ),
          child: Center(
            child: isBackspace
                ? const Icon(
                    Icons.backspace_outlined,
                    color: _offBlack,
                    size: 24,
                  )
                : Text(
                    text,
                    style: const TextStyle(
                      fontSize: 32,
                      color: _offBlack,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
          ),
        ),
      );
    });
  }

  Widget _buildContinueButton(
    MakePaymentController controller,
    BuildContext context,
  ) {
    return ElevatedButton(
      onPressed: () => controller.onContinuePressed(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.black,
        fixedSize: Size(double.maxFinite, 56.rh),
      ),
      child: const Text(
        'Continue',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: _white,
        ),
      ),
    ).paddingXY(X: 56.rw);
  }
}

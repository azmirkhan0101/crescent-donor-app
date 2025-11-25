import 'package:cresent_charge_user_app/common-widgets/custom_app_bar.dart';
import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/payment_method_controller.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:get/get.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  late final PaymentMethodController controller;
  final cardHolderNameController = TextEditingController(
    text: kDebugMode ? 'John Doe' : '',
  );
  final formKey = GlobalKey<FormState>();
  bool isCardComplete = false;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<PaymentMethodController>()
        ? Get.find<PaymentMethodController>()
        : Get.put(PaymentMethodController());
  }

  @override
  void dispose() {
    cardHolderNameController.dispose();
    super.dispose();
  }

  Future<void> _handleAddCard() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (!isCardComplete) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill in complete card details'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    final success = await controller.setupCard(
      cardHolderName: cardHolderNameController.text.trim(),
      isDefault: true,
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Card added successfully'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            controller.errorMessage.value.isEmpty
                ? 'Failed to add card'
                : controller.errorMessage.value,
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Add New Card',
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Obx(() {
          return SingleChildScrollView(
            child: Column(
              children: [
                // Card image at top
                Assets.onboarding.cardInfo.svg(),
                32.rh.heightWidth,

                // Form fields
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Card Holder Name
                      Text(
                        'Card Holder Name',
                        style: TextStyle(
                          fontSize: 14.rfs,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0D0D15),
                        ),
                      ),
                      SizedBox(height: 8.rh),
                      TextFormField(
                        controller: cardHolderNameController,
                        decoration: InputDecoration(
                          hintText: 'John Doe',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.rw),
                            borderSide: const BorderSide(
                              color: Color(0xFFEDEDED),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.rw),
                            borderSide: const BorderSide(
                              color: Color(0xFFEDEDED),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.rw,
                            vertical: 16.rh,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter card holder name';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 16.rh),

                      // Card Details
                      Text(
                        'Card Details',
                        style: TextStyle(
                          fontSize: 14.rfs,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0D0D15),
                        ),
                      ),
                      SizedBox(height: 8.rh),

                      // Stripe Card Field
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.rw),
                          border: Border.all(color: const Color(0xFFEDEDED)),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.rw,
                          vertical: 8.rh,
                        ),
                        child: stripe.CardField(
                          onCardChanged: (card) {
                            setState(() {
                              isCardComplete = card?.complete ?? false;
                            });
                          },
                          enablePostalCode: true,
                          style: TextStyle(
                            fontSize: 14.rfs,
                            color: const Color(0xFF0D0D15),
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              fontSize: 14.rfs,
                              color: const Color(0xFF9E9E9E),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 16.rh),

                      // Security notice
                      Container(
                        padding: EdgeInsets.all(12.rw),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F9FF),
                          borderRadius: BorderRadius.circular(8.rw),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.lock_outline,
                              size: 20.rw,
                              color: const Color(0xFF0369A1),
                            ),
                            SizedBox(width: 8.rw),
                            Expanded(
                              child: Text(
                                'Your card information is encrypted and secure',
                                style: TextStyle(
                                  fontSize: 12.rfs,
                                  color: const Color(0xFF0369A1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      if (controller.errorMessage.value.isNotEmpty) ...[
                        SizedBox(height: 16.rh),
                        Container(
                          padding: EdgeInsets.all(12.rw),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEE2E2),
                            borderRadius: BorderRadius.circular(8.rw),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 20.rw,
                                color: const Color(0xFFDC2626),
                              ),
                              SizedBox(width: 8.rw),
                              Expanded(
                                child: Text(
                                  controller.errorMessage.value,
                                  style: TextStyle(
                                    fontSize: 12.rfs,
                                    color: const Color(0xFFDC2626),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ).paddingXY(X: 16.rw),
                ),

                24.rh.heightWidth,

                // Add Card Button
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: controller.isAddingCard.value
                          ? null
                          : _handleAddCard,
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(double.maxFinite, 56.rh),
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: Colors.grey,
                      ),
                      child: controller.isAddingCard.value
                          ? SizedBox(
                              width: 20.rw,
                              height: 20.rh,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : const Text('Add Card'),
                    ),
                    24.heightWidth,
                  ],
                ).paddingXY(X: 40.rw),
              ],
            ).paddingXY(X: 16.rw),
          );
        }),
      ),
    );
  }
}

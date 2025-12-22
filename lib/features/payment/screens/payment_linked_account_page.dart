import 'package:cresent_charge_user_app/common-widgets/custom_app_bar.dart';
import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/payment/controllers/payment_method_controller.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class PaymentLinkedAccountPage extends StatefulWidget {
  const PaymentLinkedAccountPage({super.key});

  @override
  State<PaymentLinkedAccountPage> createState() =>
      _PaymentLinkedAccountPageState();
}

class _PaymentLinkedAccountPageState extends State<PaymentLinkedAccountPage> {
  final paymentMethodController = Get.put(PaymentMethodController());

  @override
  void initState() {
    super.initState();
  }

  // final bool hasLinkedAccounts = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: CustomAppBar(
        title: 'Linked Account',
        backgroundColor: const Color(0xFFF7F7F7),
        actions: [IconButton(onPressed: () {}, icon: Assets.common.add.svg())],
      ),
      body: SafeArea(
        child: Obx(() {
          if (paymentMethodController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return RefreshIndicator(
            onRefresh: paymentMethodController.fetchPaymentMethods,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      // Content based on account state
                      Expanded(
                        child: paymentMethodController.paymentMethods.isNotEmpty
                            ? _buildLinkedAccountsContent()
                            : _buildNoAccountsContent(),
                      ),

                      // Add Account button
                      ElevatedButton(
                        onPressed: () {
                          context.pushNamed(RoutePath.addCard);
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(double.maxFinite, 56.rh),
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                        ),
                        child: Text('Add Account'),
                      ).paddingXY(X: 56.rw),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildNoAccountsContent() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Card image
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.all(16.rw),
            child: Assets.home.atmCard.svg(
              width: double.maxFinite,
              height: 217.rh,
              fit: BoxFit.contain,
            ),
          ),
          // Divider
          Divider(
            height: 1.rh,
            color: const Color(0xFFEDEDED),
          ).paddingAll(16.rw),

          // Payment options
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFFEDEDED)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.rw),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 24.rh),
                  ),
                  child: Assets.home.applePay.svg(),
                ),
              ),
              SizedBox(width: 8.rw),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFFEDEDED)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.rw),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 24.rh),
                  ),
                  child: Assets.home.gpay.svg(),
                ),
              ),
            ],
          ).paddingXY(X: 16.rw),
        ],
      ),
    );
  }

  Widget _buildLinkedAccountsContent() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Payment cards list from API
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.rw),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Display actual payment methods from API with swipe-to-delete
                ...paymentMethodController.paymentMethods.map((paymentMethod) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.rh),
                    child: Dismissible(
                      key: ValueKey('pm_${paymentMethod.id}'),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 16.rw),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFE8E8),
                          borderRadius: BorderRadius.circular(12.rw),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.delete,
                              color: const Color(0xFFD32F2F),
                              size: 20.rw,
                            ),
                            SizedBox(width: 8.rw),
                            Text(
                              'Delete',
                              style: TextStyle(
                                color: const Color(0xFFD32F2F),
                                fontSize: 12.rfs,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      confirmDismiss: (direction) async {
                        final ok = await paymentMethodController
                            .deletePaymentMethod(paymentMethod.id);
                        if (!ok && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                paymentMethodController
                                        .errorMessage
                                        .value
                                        .isNotEmpty
                                    ? paymentMethodController.errorMessage.value
                                    : 'Unable to delete payment method',
                              ),
                            ),
                          );
                        }
                        return ok;
                      },
                      child: InkWell(
                        onTap: () {
                          context.pushNamed(
                            RoutePath.confirmDonation,
                            queryParameters: {
                              'paymentMethodId': paymentMethod.id,
                            },
                          );
                        },
                        child: _buildCardItem(
                          cardBrand: paymentMethod.cardBrand,
                          cardHolderName:
                              paymentMethod.cardHolderName ?? 'Card Holder',
                          cardLast4: paymentMethod.cardLast4,
                          cardExpMonth: paymentMethod.cardExpMonth,
                          cardExpYear: paymentMethod.cardExpYear,
                          isDefault: paymentMethod.isDefault,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),

          16.rh.heightWidth,

          // Divider
          Divider(
            height: 32.rh,
            color: const Color(0xFFEDEDED),
          ).paddingXY(X: 16.rw),

          16.rh.heightWidth,

          // Add another account
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.rw),
            child: GestureDetector(
              onTap: () {
                context.pushNamed(RoutePath.addCard);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const AddCardPage()),
                // );
              },
              child: _buildAccountItem(
                icon: Assets.common.add.svg(),
                title: 'Add another account',
                subtitle: null,
                showChevron: true,
              ),
            ),
          ),

          SizedBox(height: 16.rh),
        ],
      ),
    );
  }

  Widget _buildCardItem({
    required String cardBrand,
    required String cardHolderName,
    required String cardLast4,
    required int cardExpMonth,
    required int cardExpYear,
    required bool isDefault,
  }) {
    // Get card brand icon
    Widget cardIcon;
    String cardTitle;

    switch (cardBrand.toLowerCase()) {
      case 'visa':
        cardIcon = Icon(
          Icons.credit_card,
          size: 24.rw,
          color: const Color(0xFF1A1F71),
        );
        cardTitle = 'Visa';
        break;
      case 'mastercard':
        cardIcon = Icon(
          Icons.credit_card,
          size: 24.rw,
          color: const Color(0xFFEB001B),
        );
        cardTitle = 'Mastercard';
        break;
      case 'amex':
      case 'american_express':
        cardIcon = Icon(
          Icons.credit_card,
          size: 24.rw,
          color: const Color(0xFF006FCF),
        );
        cardTitle = 'American Express';
        break;
      default:
        cardIcon = Icon(
          Icons.credit_card,
          size: 24.rw,
          color: const Color(0xFF5F6368),
        );
        cardTitle = cardBrand.toUpperCase();
    }

    return Container(
      padding: EdgeInsets.all(8.rw),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.rw),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF000C0B).withValues(alpha: 0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40.rw,
            height: 40.rh,
            padding: EdgeInsets.symmetric(horizontal: 6.rw),
            decoration: BoxDecoration(
              color: Color(0xFFF9F7F9),
              borderRadius: BorderRadius.circular(40.rw),
            ),
            child: Center(child: cardIcon),
          ),
          SizedBox(width: 8.rw),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      cardTitle,
                      style: TextStyle(
                        fontSize: 12.rfs,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0D0D15),
                      ),
                    ),
                    if (isDefault) ...[
                      SizedBox(width: 8.rw),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.rw,
                          vertical: 2.rh,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50),
                          borderRadius: BorderRadius.circular(4.rw),
                        ),
                        child: Text(
                          'Default',
                          style: TextStyle(
                            fontSize: 8.rfs,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 6.rh),
                Text(
                  cardHolderName,
                  style: TextStyle(
                    fontSize: 10.rfs,
                    color: const Color(0xFF0D0D15),
                    letterSpacing: 0.2,
                  ),
                ),
                SizedBox(height: 2.rh),
                Text(
                  '•••• •••• •••• $cardLast4 | Exp: ${cardExpMonth.toString().padLeft(2, '0')}/${cardExpYear.toString().substring(2)}',
                  style: TextStyle(
                    fontSize: 10.rfs,
                    color: const Color(0xFF5F6368),
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            size: 20.rw,
            color: const Color(0xFF5F6368),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountItem({
    required Widget icon,
    required String title,
    String? subtitle,
    bool showChevron = true,
  }) {
    return Container(
      padding: EdgeInsets.all(8.rw),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.rw),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF000C0B).withValues(alpha: 0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40.rw,
            height: 40.rh,
            padding: EdgeInsets.symmetric(horizontal: 6.rw),
            decoration: BoxDecoration(
              color: Color(0xFFF9F7F9),
              borderRadius: BorderRadius.circular(40.rw),
            ),
            child: Center(child: icon),
          ),
          SizedBox(width: 8.rw),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.rfs,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0D0D15),
                  ),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: 6.rh),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 10.rfs,
                      color: const Color(0xFF0D0D15),
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (showChevron)
            Icon(
              Icons.chevron_right,
              size: 20.rw,
              color: const Color(0xFF5F6368),
            ),
        ],
      ),
    );
  }
}

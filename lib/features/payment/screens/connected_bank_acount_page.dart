import 'package:cresent_charge_user_app/common-widgets/custom_app_bar.dart';
import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/get_conected_bank_acounts_controller.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/plaid_controller.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/donate_now_controller.dart';
import 'package:cresent_charge_user_app/features/payment/controllers/payment_method_controller.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ConnectedBankAccountPage extends StatefulWidget {
  const ConnectedBankAccountPage({super.key});

  @override
  State<ConnectedBankAccountPage> createState() =>
      _ConnectedBankAccountPageState();
}

class _ConnectedBankAccountPageState extends State<ConnectedBankAccountPage> {
  final paymentMethodController = Get.put(PaymentMethodController());
  final connectedBankAccountsController = Get.find<GetConnectedBankAccounts>();
  final PlaidController plaidCtrl = Get.isRegistered<PlaidController>()
      ? Get.find<PlaidController>()
      : Get.put(PlaidController());

  @override
  void initState() {
    super.initState();
    connectedBankAccountsController.getConnectedBankAccounts();

    // Set up callback to refresh bank accounts after successful Plaid link
    plaidCtrl.onSuccessCallback = (event) {
      connectedBankAccountsController.getConnectedBankAccounts();
    };
  }

  // final bool hasLinkedAccounts = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: CustomAppBar(
        title: 'Bank Accounts',
        backgroundColor: const Color(0xFFF7F7F7),
        actions: [
          Obx(() {
            return IconButton(
              onPressed:
                  plaidCtrl.isLoadingConfiguration.value ||
                      plaidCtrl.createPlaidTokenCtrl.isLinkTokenLoading
                  ? null
                  : () => plaidCtrl.createLinkTokenConfiguration(),
              icon:
                  plaidCtrl.isLoadingConfiguration.value ||
                      plaidCtrl.createPlaidTokenCtrl.isLinkTokenLoading
                  ? SizedBox(
                      width: 20.rw,
                      height: 20.rh,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.black,
                      ),
                    )
                  : Assets.common.add.svg(),
            );
          }),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          if (connectedBankAccountsController.isBankConnectionLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return RefreshIndicator(
            onRefresh: connectedBankAccountsController.getConnectedBankAccounts,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      // Content based on account state
                      Expanded(
                        child:
                            connectedBankAccountsController
                                .connectedAccountsDataModel
                                .isNotEmpty
                            ? _buildLinkedAccountsContent()
                            : _buildNoAccountsContent(),
                      ),
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
    return Column(
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
        Divider(height: 1.rh, color: const Color(0xFFEDEDED)).paddingAll(16.rw),

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

        Spacer(),
        Obx(() {
          return ElevatedButton(
            onPressed:
                plaidCtrl.isLoadingConfiguration.value ||
                    plaidCtrl.createPlaidTokenCtrl.isLinkTokenLoading
                ? null
                : () => plaidCtrl.createLinkTokenConfiguration(),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(double.maxFinite, 56.rh),
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
            child:
                plaidCtrl.isLoadingConfiguration.value ||
                    plaidCtrl.createPlaidTokenCtrl.isLinkTokenLoading
                ? SizedBox(
                    width: 20.rw,
                    height: 20.rh,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text('Add Account'),
          );
        }).paddingXY(X: 56.rw),
      ],
    );
  }

  Widget _buildLinkedAccountsContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...connectedBankAccountsController.connectedAccountsDataModel.map((
              bancAccount,
            ) {
              return Padding(
                padding: EdgeInsets.only(bottom: 8.rh),
                child: Dismissible(
                  key: ValueKey('pm_${bancAccount.id}'),
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
                        .deletePaymentMethod(bancAccount.id);
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
                      Get.find<DonateNowController>()
                              .selectedBankAccountId
                              .value =
                          bancAccount.id;

                      debugPrint(
                        '---> Selected Payment Method ID ---> ${Get.find<DonateNowController>().selectedBankAccountId.value}',
                      );
                      GoRouter.of(
                        context,
                      ).pushNamed(RoutePath.linkedPaymentAccount);
                    },
                    child: _buildCardItem(
                      institutionName: bancAccount.institutionName,
                      accountName: bancAccount.accountName,
                      accountType: bancAccount.accountType,
                      isConnected: bancAccount.isLinkedToActiveRoundUp,
                      organizationName:
                          bancAccount.roundUpDetails?.organizationName,
                      causeName: bancAccount.roundUpDetails?.causeName,
                      monthlyThreshold:
                          bancAccount.roundUpDetails?.monthlyThreshold,
                    ),
                  ),
                ),
              );
            }),

            // Divider
            Divider(
              height: 32.rh,
              color: const Color(0xFFEDEDED),
            ).paddingXY(X: 16.rw),

            // Add another account
            Obx(() {
              return GestureDetector(
                onTap:
                    plaidCtrl.isLoadingConfiguration.value ||
                        plaidCtrl.createPlaidTokenCtrl.isLinkTokenLoading
                    ? null
                    : () => plaidCtrl.createLinkTokenConfiguration(),
                child: Opacity(
                  opacity:
                      plaidCtrl.isLoadingConfiguration.value ||
                          plaidCtrl.createPlaidTokenCtrl.isLinkTokenLoading
                      ? 0.5
                      : 1.0,
                  child: _buildAccountItem(
                    icon:
                        plaidCtrl.isLoadingConfiguration.value ||
                            plaidCtrl.createPlaidTokenCtrl.isLinkTokenLoading
                        ? SizedBox(
                            width: 20.rw,
                            height: 20.rh,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.black,
                            ),
                          )
                        : Assets.common.add.svg(),
                    title: 'Add another account',
                    subtitle:
                        plaidCtrl.isLoadingConfiguration.value ||
                            plaidCtrl.createPlaidTokenCtrl.isLinkTokenLoading
                        ? 'Connecting...'
                        : null,
                    showChevron: true,
                  ),
                ),
              );
            }),

            SizedBox(height: 16.rh),
          ],
        ),
      ),
    );
  }

  Widget _buildCardItem({
    required String institutionName,
    required String accountName,
    required String accountType,
    required bool isConnected,
    String? organizationName,
    String? causeName,
    double? monthlyThreshold,
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
            child: Center(
              child: Icon(
                Icons.account_balance, // bank icon
                size: 24.rw,
                color: const Color(0xFF5F6368),
              ),
            ),
          ),
          SizedBox(width: 8.rw),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      institutionName,
                      style: TextStyle(
                        fontSize: 12.rfs,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0D0D15),
                      ),
                    ),
                    if (isConnected) ...[
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
                          'Connected',
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
                  accountName,
                  style: TextStyle(
                    fontSize: 10.rfs,
                    color: const Color(0xFF0D0D15),
                    letterSpacing: 0.2,
                  ),
                ),
                SizedBox(height: 2.rh),
                if (organizationName != null &&
                    causeName != null &&
                    monthlyThreshold != null)
                  Text(
                    '$organizationName | $causeName | \$${monthlyThreshold.toStringAsFixed(2)} / month',
                    style: TextStyle(
                      fontSize: 10.rfs,
                      color: const Color(0xFF5F6368),
                      letterSpacing: 0.2,
                    ),
                  )
                else
                  Text(
                    'No round-up configured',
                    style: TextStyle(
                      fontSize: 10.rfs,
                      color: const Color(0xFF9E9E9E),
                      fontStyle: FontStyle.italic,
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

import 'package:cresent_charge_user_app/common-widgets/custom_app_bar.dart';
import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/get_round_up_bank_connection_controller.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/plaid_controller.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/donate_now_controller.dart';
import 'package:cresent_charge_user_app/features/payment/controllers/connect_basiq_controller.dart';
import 'package:cresent_charge_user_app/features/payment/controllers/payment_method_controller.dart';
import 'package:cresent_charge_user_app/features/payment/widgets/bank_connection_popup_menu.dart';
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
  final connectedBankAccountsController = Get.find<GetRoundUpBankConnection>();
  final PlaidController plaidCtrl = Get.isRegistered<PlaidController>()
      ? Get.find<PlaidController>()
      : Get.put(PlaidController());
  final basiqController = Get.find<ConnectBasiqController>();

  @override
  void initState() {
    super.initState();
    connectedBankAccountsController.fetchRoundUpBankConnection();

    // Set up callback to refresh bank accounts after successful Plaid link
    plaidCtrl.onSuccessCallback = (event) {
      connectedBankAccountsController.fetchRoundUpBankConnection();
    };
  }

  // final bool hasLinkedAccounts = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Obx(() {
          if (connectedBankAccountsController.isLoading.value ||
              connectedBankAccountsController.isBasiqConnectionLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return RefreshIndicator(
            onRefresh:
                connectedBankAccountsController.fetchRoundUpBankConnection,
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
                                .roundUpBankConnectionModel
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

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      title: 'Bank Accounts',
      backgroundColor: const Color(0xFFF7F7F7),
      actions: [
        Obx(() {
          return BankConnectionPopupMenu(
            isLoading:
                plaidCtrl.isLoadingConfiguration.value ||
                plaidCtrl.createPlaidTokenCtrl.isLinkTokenLoading ||
                basiqController.isLoading.value,
            icon: Assets.common.add.svg(),
            onPlaidSelected: () => plaidCtrl.createLinkTokenConfiguration(),
            onBasiqSelected: _connectBasiq,
          );
        }),
      ],
    );
  }

  Widget _buildNoAccountsContent() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.rw),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustration
            Container(
              width: 200.rw,
              height: 200.rh,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.account_balance_outlined,
                size: 80.rw,
                color: const Color(0xFF9E9E9E),
              ),
            ),

            SizedBox(height: 32.rh),

            // Title
            Text(
              'No Connected Bank Accounts',
              style: TextStyle(
                fontSize: 20.rfs,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2C2C2C),
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 12.rh),

            // Subtitle
            Text(
              'Please connect an account to start using round-up donations and make a difference.',
              style: TextStyle(
                fontSize: 14.rfs,
                color: const Color(0xFF757575),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 40.rh),

            // Connect Account Button
            Obx(() {
              return BankConnectionPopupMenu(
                onPlaidSelected: () {
                  if (!plaidCtrl.isLoadingConfiguration.value &&
                      !plaidCtrl.createPlaidTokenCtrl.isLinkTokenLoading) {
                    plaidCtrl.createLinkTokenConfiguration();
                  }
                },
                onBasiqSelected: _connectBasiq,
                isLoading:
                    plaidCtrl.isLoadingConfiguration.value ||
                    plaidCtrl.createPlaidTokenCtrl.isLinkTokenLoading ||
                    basiqController.isLoading.value,
                icon: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.rw,
                    vertical: 16.rh,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12.rw),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (plaidCtrl.isLoadingConfiguration.value ||
                          plaidCtrl.createPlaidTokenCtrl.isLinkTokenLoading)
                        SizedBox(
                          width: 20.rw,
                          height: 20.rh,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      else
                        Text(
                          'Connect Bank Account',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.rfs,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }),

            SizedBox(height: 16.rh),

            // Help text
            Text(
              'Secure and encrypted connection',
              style: TextStyle(
                fontSize: 12.rfs,
                color: const Color(0xFF9E9E9E),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLinkedAccountsContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...connectedBankAccountsController.roundUpBankConnectionModel.map((
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
              bool isLoading =
                  plaidCtrl.isLoadingConfiguration.value ||
                  plaidCtrl.createPlaidTokenCtrl.isLinkTokenLoading ||
                  basiqController.isLoading.value;
              return BankConnectionPopupMenu(
                onPlaidSelected: () {
                  if (!isLoading) {
                    plaidCtrl.createLinkTokenConfiguration();
                  }
                  // print('Plaid connection selected');
                },
                onBasiqSelected: _connectBasiq,
                isLoading: isLoading,
                icon: _buildAccountItem(
                  icon: Assets.common.add.svg(),
                  title: 'Add another account',
                  subtitle: null,
                  showChevron: false,
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

  void _connectBasiq() async {
    // debugPrint('Basiq connection selected');
    // final basiqController = Get.find<ConnectBasiqController>();
    bool success = await basiqController.connectBasiq();
    if (success) {
      String url = basiqController.url.value;
      debugPrint('Basiq url: $url');
      if (url.isNotEmpty && mounted) {
        context.push(
          '${RoutePath.basiqWebView.addBasePath}?url=${Uri.encodeComponent(url)}',
        );
      }
    } else {
      debugPrint('Basiq connection failed');
    }
  }
}

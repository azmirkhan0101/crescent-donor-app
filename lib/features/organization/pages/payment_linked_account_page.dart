import 'package:cresent_charge_user_app/common-widgets/custom_app_bar.dart';
import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/routes/route_path.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class PaymentLinkedAccountPage extends StatelessWidget {
  const PaymentLinkedAccountPage({super.key});

  final bool hasLinkedAccounts = true;

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
        child: Column(
          children: [
            // Content based on account state
            Expanded(
              child: hasLinkedAccounts
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
          // Payment accounts list
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.rw),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Apple Pay
                _buildAccountItem(
                  icon: Assets.home.applePay.svg(),
                  title: 'Apple Pay',
                  subtitle: 'Talha Shafqat',
                ),
                SizedBox(height: 8.rh),

                // Google Pay
                _buildAccountItem(
                  icon: Assets.home.gpay.svg(),
                  title: 'Google Pay',
                  subtitle: 'Talha Shafqat',
                ),
                SizedBox(height: 8.rh),

                // Chase Bank
                _buildAccountItem(
                  icon: Assets.home.chaseIcon.svg(),
                  title: 'Chase',
                  subtitle: 'CHASUS33 XXXXXXXXX 1234',
                ),
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
            child: _buildAccountItem(
              icon: Assets.common.add.svg(),
              title: 'Add another account',
              subtitle: null,
              showChevron: true,
            ),
          ),

          SizedBox(height: 16.rh),
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

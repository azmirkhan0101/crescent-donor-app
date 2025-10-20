import 'package:cresent_charge_user_app/common-widgets/custom_app_bar.dart';
import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/features/rewards/widgets/store_overview_tab.dart';
import 'package:cresent_charge_user_app/features/rewards/widgets/store_rewards_tab.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';

class StoreProfilePage extends StatefulWidget {
  const StoreProfilePage({
    super.key,
    required this.storeName,
    required this.storeDescription,
    required this.storeImage,
    required this.storeLogo,
  });

  final String storeName;
  final String storeDescription;
  final String storeImage;
  final Widget storeLogo;

  @override
  State<StoreProfilePage> createState() => _StoreProfilePageState();
}

class _StoreProfilePageState extends State<StoreProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: CustomAppBar(
        title: "Store Profile",
        backgroundColor: const Color(0xFFF7F7F7),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(height: 160.rh),
                  Container(
                    height: 120.rh,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.rw),
                      image: DecorationImage(
                        image: AssetImage(
                          Assets.rewards.storeProfileBannerImage.path,
                        ),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.rh,
                    right: 0.rw,
                    left: 0.rw,
                    child: Container(
                      width: 80.rw,
                      height: 80.rh,
                      decoration: const BoxDecoration(
                        color: Color(0xFF000C0B),
                        shape: BoxShape.circle,
                      ),
                      child: Center(child: widget.storeLogo),
                    ),
                  ),
                ],
              ).paddingX(16.rw),

              16.rh.heightWidth,

              Text(
                widget.storeName,
                style: TextStyle(
                  color: const Color(0xFF000C0B),
                  fontSize: 18.rfs,
                  fontFamily: 'Inter Display',
                  fontWeight: FontWeight.w600,
                ),
              ),
              4.rh.heightWidth,

              Text(
                widget.storeDescription,
                style: TextStyle(
                  color: const Color(0xFF818F8D),
                  fontSize: 12.rfs,
                  fontFamily: 'Inter Display',
                  fontWeight: FontWeight.w400,
                ),
              ),
              8.rh.heightWidth,

              Text(
                'You shop, ${widget.storeName} gives!',
                style: TextStyle(
                  color: const Color(0xFF000C0B),
                  fontSize: 14.rfs,
                  fontFamily: 'Inter Display',
                  fontWeight: FontWeight.w500,
                ),
              ),
              28.rh.heightWidth,

              // Tab Bar
              TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: const Color(0xFF000C0B),
                      width: 1,
                    ),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                // indicatorPadding: const EdgeInsets.only(bottom: 16),
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: const TextStyle(
                  fontFamily: 'InterDisplay',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontFamily: 'InterDisplay',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                labelPadding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                tabs: const [
                  Tab(text: 'Overview', height: 32),
                  Tab(text: 'Rewards', height: 32),
                ],
              ),

              // Tab Content
              AnimatedBuilder(
                animation: _tabController,
                builder: (context, child) {
                  if (_tabController.index == 0) {
                    return StoreOverviewTab(storeName: widget.storeName);
                  } else {
                    return const StoreRewardsTab();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

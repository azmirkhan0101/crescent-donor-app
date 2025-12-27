import 'package:cresent_charge_user_app/common-widgets/custom_app_bar.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/get_store_profile_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/widgets/store_overview_tab.dart';
import 'package:cresent_charge_user_app/features/rewards/widgets/store_rewards_tab.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class StoreProfilePage extends StatefulWidget {
  const StoreProfilePage({super.key, required this.storeId});

  final String storeId;

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
        child: GetX<GetStoreProfileController>(
          initState: (state) {
            state.controller!.fetchStoreProfile(widget.storeId);
          },
          builder: (controller) {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
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
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.rw),
                          child: Image.network(
                            controller.storeProfile.value?.coverImage ?? '',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                child: const Center(
                                  child: Icon(
                                    Icons.store,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0.rh,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: Image.network(
                                  controller.storeProfile.value?.logoImage ??
                                      '',
                                  width: 80.rw,
                                  height: 80.rh,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey[300],
                                      child: const Center(
                                        child: Icon(
                                          Icons.store,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ).paddingX(16.rw),

                  16.rh.heightWidth,

                  Text(
                    controller.storeProfile.value?.name ?? '',
                    style: TextStyle(
                      color: const Color(0xFF000C0B),
                      fontSize: 18.rfs,
                      fontFamily: 'Inter Display',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  4.rh.heightWidth,

                  Text(
                    controller.storeProfile.value?.tagLine ?? '',
                    style: TextStyle(
                      color: const Color(0xFF818F8D),
                      fontSize: 12.rfs,
                      fontFamily: 'Inter Display',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  8.rh.heightWidth,

                  Text(
                    'You shop, ${controller.storeProfile.value?.name ?? ''} gives!',
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
                        if (controller.storeProfile.value == null) {
                          return const Center(
                            child: Text('No store profile data available.'),
                          );
                        }
                        return StoreOverviewTab(
                          storeProfile: controller.storeProfile.value!,
                        );
                      } else {
                        final profile = controller.storeProfile.value;
                        if (profile == null) {
                          return const Center(
                            child: Text('No store profile data available.'),
                          );
                        }
                        return StoreRewardsTab(businessId: profile.id);
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

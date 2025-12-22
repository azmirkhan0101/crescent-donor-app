import 'package:cresent_charge_user_app/common-widgets/custom_app_bar.dart';
import 'package:cresent_charge_user_app/features/home/widgets/verified_charity_card.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/organization_controller.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifiedCharitiesPage extends StatefulWidget {
  const VerifiedCharitiesPage({super.key});

  @override
  State<VerifiedCharitiesPage> createState() => _VerifiedCharitiesPageState();
}

class _VerifiedCharitiesPageState extends State<VerifiedCharitiesPage> {
  final ScrollController _scrollController = ScrollController();
  final OrganizationController controller = Get.find<OrganizationController>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      controller.loadMoreOrganizations();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Verified Charities'),
      body: GetBuilder<OrganizationController>(
        builder: (controller) {
          return Stack(
            children: [
              GridView.count(
                controller: _scrollController,
                crossAxisCount: 2,
                padding: EdgeInsets.all(16.0.rw),
                crossAxisSpacing: 8.0.rw,
                mainAxisSpacing: 8.0.rh,
                childAspectRatio: 2 / 3,
                children: controller.organizationsList.map((org) {
                  return VerifiedCharityCard(
                    id: org.id,
                    title: org.name,
                    location: org.address ?? '',
                    category: org.serviceType,
                    backgroundColor: Colors.green,
                    imagePath: org.logoImage,
                  );
                }).toList(),
              ),
              if (controller.isLoadingMore.value)
                Positioned(
                  bottom: 16.rh,
                  left: 0,
                  right: 0,
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        },
      ),
    );
  }
}

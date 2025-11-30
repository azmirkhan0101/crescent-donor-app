import 'package:cresent_charge_user_app/common-widgets/fill-button/custom_filled_button.dart';
import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/auth/controllers/profile_controller.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/auth_header.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/auth_title_section.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class UploadProfilePicturePage extends StatefulWidget {
  const UploadProfilePicturePage({super.key});

  @override
  State<UploadProfilePicturePage> createState() =>
      _UploadProfilePicturePageState();
}

class _UploadProfilePicturePageState extends State<UploadProfilePicturePage> {
  late final ProfileController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<ProfileController>()
        ? Get.find<ProfileController>()
        : Get.put(ProfileController());
  }

  /// Show bottom sheet if click on change photo text
  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16.rw),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                controller.pickImageFromGallery();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(context);
                controller.pickImageFromCamera();
              },
            ),
            if (controller.profileImage.value != null)
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text(
                  'Remove Photo',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context);
                  controller.removeProfileImage();
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return [
      AuthHeader(),
      32.heightWidth,
      AuthTitleSection(title: AppStrings.uploadProfilePicture),
      Spacer(),
      Obx(() {
        if (controller.profileImage.value != null) {
          return Column(
            children: [
              CircleAvatar(
                radius: 80.rfs,
                backgroundImage: FileImage(controller.profileImage.value!),
              ),
              16.heightWidth,
              TextButton.icon(
                onPressed: _showImageSourceDialog,
                icon: const Icon(Icons.edit),
                label: const Text('Change Photo'),
              ),
            ],
          );
        }
        return GestureDetector(
          onTap: _showImageSourceDialog,
          child: Column(
            children: [
              Assets.onboarding.uploadProfilePicture.svg(),
              16.heightWidth,
              Text(
                AppStrings.tapToAddProfilePicture,
                style: TextStyle(
                  fontSize: 14.rfs,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grayColor,
                ),
              ),
            ],
          ),
        );
      }),
      Spacer(),
      CustomFilledButton(
        title: AppStrings.continueText,
        onTap: () {
          // context.pushNamed(RoutePath.addCard, extra: {'fromSignup': true});
          context.pushNamed(RoutePath.termsAgreement);
        },
      ).paddingXY(X: 40.rw),
      60.rh.heightWidth,
    ].scaffoldSafeAreaColumn(horizontalPadding: 16.rw);
  }
}

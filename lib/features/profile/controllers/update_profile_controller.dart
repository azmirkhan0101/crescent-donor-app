import 'dart:convert';
import 'dart:io';

import 'package:cresent_charge_user_app/features/profile/controllers/get_profile_controller.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final stateController = TextEditingController();
  final postalCodeController = TextEditingController();
  final phoneController = TextEditingController();

  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final imageFile = Rx<File?>(null);

  final _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    // Prefill from existing profile
    final profileCtrl = Get.find<GetProfileController>();
    final profile = profileCtrl.profile.value;
    if (profile != null) {
      nameController.text = profile.name;
      emailController.text = profile.auth.email;
      addressController.text = profile.address;
      stateController.text = profile.state;
      postalCodeController.text = profile.postalCode;
      phoneController.text = profile.phoneNumber ?? '';
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    stateController.dispose();
    postalCodeController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  Future<void> pickImageFromGallery() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (picked != null) {
      imageFile.value = File(picked.path);
    }
  }

  Future<void> pickImageFromCamera() async {
    final picked = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );
    if (picked != null) {
      imageFile.value = File(picked.path);
    }
  }

  Future<bool> submit() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final data = {
        'name': nameController.text.trim(),
        'address': addressController.text.trim(),
        'state': stateController.text.trim(),
        'postalCode': postalCodeController.text.trim(),
        'phoneNumber': phoneController.text.trim(),
      };

      final fields = {'data': jsonEncode(data)};

      final files = <MultipartBody>[];
      final file = imageFile.value;
      if (file != null) {
        files.add(MultipartBody(key: 'image', file: file));
      }

      final network = Get.find<NetworkHelper>();
      final result = await network.multipart<Map<String, dynamic>>(
        url: '${ApiUrl.baseUrl}/client/update-profile',
        method: 'PATCH',
        fields: fields,
        files: files,
        withAuth: true,
        parser: (data) => data,
      );

      return result.fold(
        (err) {
          errorMessage.value = err.message ?? 'Failed to update profile';
          debugPrint('Profile update error: ${err.message}');
          return false;
        },
        (data) async {
          // Refresh profile data after successful update
          await Get.find<GetProfileController>().fetchProfile();
          return true;
        },
      );
    } catch (e) {
      errorMessage.value = 'Unexpected error';
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}

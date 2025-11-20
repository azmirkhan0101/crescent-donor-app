import 'dart:convert';
import 'dart:io';

import 'package:cresent_charge_user_app/features/auth/models/create_profile_request_model.dart';
import 'package:cresent_charge_user_app/features/auth/models/create_profile_response_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  // GlobalKey for the forms
  final fewDetailsFormKey = GlobalKey<FormState>();
  final addCardFormKey = GlobalKey<FormState>();

  // Few Details Controllers
  final nameController = TextEditingController(
    text: kDebugMode ? 'John Doe' : '',
  );
  final addressController = TextEditingController(
    text: kDebugMode ? '123 Main Street' : '',
  );
  final stateController = TextEditingController(
    text: kDebugMode ? 'California' : '',
  );
  final postalCodeController = TextEditingController(
    text: kDebugMode ? '90001' : '',
  );

  // Card Details Controllers
  final nameInCardController = TextEditingController(
    text: kDebugMode ? 'John Doe' : '',
  );
  final cardNumberController = TextEditingController(
    text: kDebugMode ? '4242424242424242' : '',
  );
  final cardExpiryDateController = TextEditingController(
    text: kDebugMode ? '05/26' : '',
  );
  final cardCVCController = TextEditingController(
    text: kDebugMode ? '123' : '',
  );

  // Observable variables
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  Rx<File?> profileImage = Rx<File?>(null);

  // Store profile response data
  Rx<ProfileData?> profileData = Rx<ProfileData?>(null);

  final ImagePicker _picker = ImagePicker();

  @override
  void onClose() {
    nameController.dispose();
    addressController.dispose();
    stateController.dispose();
    postalCodeController.dispose();
    nameInCardController.dispose();
    cardNumberController.dispose();
    cardExpiryDateController.dispose();
    cardCVCController.dispose();
    super.onClose();
  }

  /// Clear all error messages
  void clearErrors() {
    errorMessage.value = '';
  }

  /// Validate name field
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  /// Validate address field
  String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address is required';
    }
    return null;
  }

  /// Validate state field
  String? validateState(String? value) {
    if (value == null || value.isEmpty) {
      return 'State is required';
    }
    return null;
  }

  /// Validate postal code field
  String? validatePostalCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Postal code is required';
    }
    if (value.length < 5) {
      return 'Invalid postal code';
    }
    return null;
  }

  /// Validate card number field
  String? validateCardNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Card number is required';
    }
    final cleanNumber = value.replaceAll(' ', '');
    if (cleanNumber.length < 13 || cleanNumber.length > 19) {
      return 'Invalid card number';
    }
    return null;
  }

  /// Validate card expiry date field
  String? validateExpiryDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Expiry date is required';
    }
    if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(value)) {
      return 'Format: MM/YY';
    }
    return null;
  }

  /// Validate CVC field
  String? validateCVC(String? value) {
    if (value == null || value.isEmpty) {
      return 'CVC is required';
    }
    if (value.length < 3 || value.length > 4) {
      return 'Invalid CVC';
    }
    return null;
  }

  /// Pick profile image from gallery
  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        profileImage.value = File(image.path);
        debugPrint('✅ Profile image selected: ${image.path}');
      }
    } catch (e) {
      errorMessage.value = 'Failed to pick image';
      debugPrint('❌ Error picking image: $e');
    }
  }

  /// Pick profile image from camera
  Future<void> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        profileImage.value = File(image.path);
        debugPrint('✅ Profile image captured: ${image.path}');
      }
    } catch (e) {
      errorMessage.value = 'Failed to capture image';
      debugPrint('❌ Error capturing image: $e');
    }
  }

  /// Remove selected profile image
  void removeProfileImage() {
    profileImage.value = null;
  }

  /// Create profile with all collected data
  Future<bool> createProfile() async {
    try {
      clearErrors();

      // Validate few details form
      if (!fewDetailsFormKey.currentState!.validate()) {
        errorMessage.value = 'Please fill in all required details';
        return false;
      }

      // Validate card details form
      if (!addCardFormKey.currentState!.validate()) {
        errorMessage.value = 'Please fill in all card details';
        return false;
      }

      isLoading.value = true;

      // Create request model
      final requestModel = CreateProfileRequestModel(
        role: 'CLIENT',
        name: nameController.text.trim(),
        address: addressController.text.trim(),
        state: stateController.text.trim(),
        postalCode: postalCodeController.text.trim(),
        nameInCard: nameInCardController.text.trim(),
        cardNumber: cardNumberController.text.replaceAll(' ', ''),
        cardExpiryDate: cardExpiryDateController.text.trim(),
        cardCVC: cardCVCController.text.trim(),
      );

      // Prepare fields for multipart request
      final fields = <String, String>{
        'data': jsonEncode(requestModel.toJson()),
      };

      // Prepare files for multipart request
      final files = <MultipartBody>[];
      if (profileImage.value != null) {
        files.add(MultipartBody(key: 'clientImage', file: profileImage.value!));
      }

      // Call create-profile API
      final networkHelper = Get.find<NetworkHelper>();
      final result = await networkHelper.multipart<CreateProfileResponseModel>(
        url: ApiUrl.createProfile,
        method: 'POST',
        fields: fields,
        files: files,
        parser: (data) => CreateProfileResponseModel.fromJson(data),
        withAuth: false,
      );

      return result.fold(
        (error) {
          // Handle error
          errorMessage.value =
              error.message ?? 'Profile creation failed. Please try again.';
          debugPrint('❌ Create profile error: ${error.message}');
          return false;
        },
        (response) async {
          // Handle success
          if (response.success) {
            // Store profile data
            profileData.value = response.data;

            debugPrint('✅ Profile created successfully: ${response.message}');
            return true;
          } else {
            errorMessage.value = response.message;
            debugPrint('❌ Profile creation failed: ${response.message}');
            return false;
          }
        },
      );
    } catch (e) {
      errorMessage.value = 'Profile creation failed. Please try again.';
      debugPrint('❌ Create profile error: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Check if few details form is valid
  bool get isFewDetailsValid {
    return nameController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        stateController.text.isNotEmpty &&
        postalCodeController.text.isNotEmpty;
  }

  /// Check if card details form is valid
  bool get isCardDetailsValid {
    return nameInCardController.text.isNotEmpty &&
        cardNumberController.text.isNotEmpty &&
        cardExpiryDateController.text.isNotEmpty &&
        cardCVCController.text.isNotEmpty;
  }
}

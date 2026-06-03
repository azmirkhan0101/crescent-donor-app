import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cresent_charge_user_app/common-widgets/places_search_field/places_search_field.dart';
import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/theme/app_colors.dart';
import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/features/profile/controllers/get_profile_controller.dart';
import 'package:cresent_charge_user_app/features/profile/controllers/update_profile_controller.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_places_flutter/model/prediction.dart';

// name, phone number, email, address, state, and pin code.
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final UpdateProfileController _updCtrl;
  final String googleApiKey = dotenv.env['GOOGLE_API_KEY']!;
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Ensure GetProfileController exists to prefill once
    if (!Get.isRegistered<GetProfileController>()) {
      Get.put<GetProfileController>(GetProfileController());
    }
    // Initialize update controller - GetX will handle disposal
    _updCtrl = Get.put(UpdateProfileController());
    _updCtrl.saveProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.rw),
        child: Column(
          children: [
            SizedBox(height: 8.rh),

            // Profile Avatar Section
            _buildProfileAvatar(),

            SizedBox(height: 16.rh),

            // Form Fields Section
            _buildFormFields(),

            SizedBox(height: 16.rh),

            // Action Buttons
            _buildActionButtons(),

            SizedBox(height: 24.rh),
          ],
        ),
      ),
    );
  }

  /// Build app bar with back button and title
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFF7F7F7),
      elevation: 0,
      leading: IconButton(
        onPressed: () => context.pop(),
        icon: Container(
          padding: EdgeInsets.all(12.rw),
          child: SvgPicture.asset(
            Assets.common.arrowLeft.path,
            width: 20.rw,
            height: 20.rh,
          ),
        ),
      ),
      title: Text(
        'Edit Profile',
        style: TextStyle(
          fontFamily: DonationFonts.familjenGrotesk,
          fontSize: 20.rfs,
          fontWeight: FontWeight.bold,
          color: AppColors.secondary,
          letterSpacing: -0.2,
        ),
      ),
      centerTitle: true,
    );
  }

  /// Build profile avatar with edit button
  Widget _buildProfileAvatar() {
    return Obx(() {
      final selectedImage = _updCtrl.imageFile.value;
      final profile = Get.find<GetProfileController>().profile.value;
      final existingImageUrl = _getFullImageUrl(profile?.image);
      final hasImage = selectedImage != null || existingImageUrl.isNotEmpty;
      final isImageLoading = _updCtrl.isImageLoading.value;

      return Stack(
        children: [
          // Main Avatar
          Container(
            width: 120.rw,
            height: 120.rh,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.surfaceContainerHigh,
                width: 1.714,
              ),
              gradient: !hasImage
                  ? const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFC08FFF), Color(0xFF8B5CF6)],
                    )
                  : null,
              image: selectedImage != null
                  ? DecorationImage(
                      image: FileImage(selectedImage),
                      fit: BoxFit.cover,
                    )
                  : (existingImageUrl.isNotEmpty
                        ? DecorationImage(
                            image: CachedNetworkImageProvider(existingImageUrl),
                            fit: BoxFit.cover,
                          )
                        : null),
            ),
            child: Stack(
              children: [
                if (!hasImage)
                  Center(
                    child: Icon(
                      Icons.person_outline,
                      size: 60.rfs,
                      color: Colors.white,
                    ),
                  ),
                if (isImageLoading)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ),
              ],
            ),
          ),

          // Edit Button
          Positioned(
            bottom: 0,
            right: 16.rw,
            child: GestureDetector(
              onTap: () async {
                // Show picker options
                showModalBottomSheet(
                  context: context,
                  builder: (_) => SafeArea(
                    child: Wrap(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.photo_library),
                          title: const Text('Pick from gallery'),
                          onTap: () async {
                            Navigator.pop(context);
                            await _updCtrl.pickImageFromGallery();
                            if (_updCtrl.imageFile.value != null) {
                              await _updCtrl.updateJustImage();
                            }
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.photo_camera),
                          title: const Text('Take a photo'),
                          onTap: () async {
                            Navigator.pop(context);
                            await _updCtrl.pickImageFromCamera();
                            if (_updCtrl.imageFile.value != null) {
                              await _updCtrl.updateJustImage();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Container(
                width: 24.rw,
                height: 24.rh,
                decoration: const BoxDecoration(
                  color: Color(0xFF000C0B),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    Assets.common.add.path,
                    width: 12.rw,
                    height: 12.rh,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  /// Build form fields section
  Widget _buildFormFields() {
    return Column(
      children: [
        // Name Field
        _buildInputField(label: 'Name', controller: _updCtrl.nameController),

        SizedBox(height: 16.rh),

        // Phone Number Field
        _buildPhoneNumberField(),

        SizedBox(height: 16.rh),

        // Email Field (read-only)
        _buildInputField(
          label: 'Email',
          controller: _updCtrl.emailController,
          readOnly: true,
        ),

        SizedBox(height: 16.rh),

        // Address Field
        // _buildInputField(
        //   label: 'Address',
        //   controller: _updCtrl.addressController,
        //   maxLines: 3,
        // ),
        PlacesSearchField(
            googleApiKey: googleApiKey,
            textEditingController: _updCtrl.addressController,
            hintText: "Address",
            onPlaceSelected: (prediction){
              _fillFromPlaceDetails(prediction);
            },
            onItemClick: (value){
              _updCtrl.addressController.text = value;
              _updCtrl.addressController.selection = TextSelection.fromPosition(
                TextPosition(offset: _updCtrl.addressController.text.length),
              );
            },
            focusNode: focusNode
        ),

        SizedBox(height: 16.rh),

        // State and Pin Code Row
        _buildStateAndPinCodeRow(),
      ],
    );
  }

  // Extract address from Google Places details - state, postal code
  Future<void> _fillFromPlaceDetails(Prediction prediction) async {
    final placeId = prediction.placeId;
    if (placeId == null) return;

    final url =
        'https://maps.googleapis.com/maps/api/place/details/json'
        '?place_id=$placeId'
        '&fields=address_component'
        '&key=$googleApiKey';

    final uri = Uri.parse(url);
    final res = await NetworkAssetBundle(uri).load("");
    final json = jsonDecode(utf8.decode(res.buffer.asUint8List()));

    final components = json['result']['address_components'] as List;

    for (var c in components) {
      final types = List<String>.from(c['types']);

      if (types.contains('administrative_area_level_1')) {
        _updCtrl.stateController.text = c['short_name'];
      } else if (types.contains('postal_code')) {
        _updCtrl.postalCodeController.text = c['long_name'];
      }
    }
  }

  /// Build individual input field
  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
    bool readOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: DonationFonts.interDisplay,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.secondary,
          ),
        ),

        SizedBox(height: 8.rh),

        Container(
          decoration: BoxDecoration(
            color: readOnly ? Colors.grey[100] : Colors.white,
            borderRadius: BorderRadius.circular(12.rw),
            border: Border.all(color: AppColors.outline, width: 1),
          ),
          child: TextFormField(
            controller: controller,
            maxLines: maxLines,
            readOnly: readOnly,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.all(16),
            ),
            style: TextStyle(
              fontFamily: DonationFonts.interDisplay,
              fontSize: 14,
              fontWeight: maxLines > 1 ? FontWeight.w400 : FontWeight.w500,
              color: readOnly ? Colors.grey[600] : AppColors.secondary,
            ),
          ),
        ),
      ],
    );
  }

  /// Build phone number field with country code dropdown
  Widget _buildPhoneNumberField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phone Number',
          style: TextStyle(
            fontFamily: DonationFonts.interDisplay,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.secondary,
          ),
        ),

        SizedBox(height: 8),

        Container(
          height: 52,
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.outline, width: 1),
          ),
          child: TextFormField(
            controller: _updCtrl.phoneController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            style: TextStyle(
              fontFamily: DonationFonts.interDisplay,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.secondary,
            ),
          ),
        ),
      ],
    );
  }

  /// Build state and pin code row
  Widget _buildStateAndPinCodeRow() {
    return Row(
      children: [
        // State Field
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'State',
                style: TextStyle(
                  fontFamily: DonationFonts.interDisplay,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondary,
                ),
              ),

              SizedBox(height: 8.rh),

              Container(
                height: 52,
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.outline, width: 1),
                ),
                child: TextFormField(
                  controller: _updCtrl.stateController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontFamily: DonationFonts.interDisplay,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondary,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(width: 16),

        // Pin Code Field
        Expanded(
          child: _buildInputField(
            label: 'Pin Code',
            controller: _updCtrl.postalCodeController,
          ),
        ),
      ],
    );
  }

  /// Build action buttons (Save and Discard Changes)
  Widget _buildActionButtons() {
    return SizedBox(
      width: 263,
      child: Column(
        children: [
          // Save Button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _saveProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Save',
                style: TextStyle(
                  fontFamily: DonationFonts.familjenGrotesk,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary,
                  letterSpacing: -0.36,
                ),
              ),
            ),
          ),

          SizedBox(height: 16),

          // Discard Changes Button
          GestureDetector(
            onTap: _discardChanges,
            child: Text(
              'Discard Changes',
              style: TextStyle(
                fontFamily: DonationFonts.interDisplay,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.secondary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  /// Save profile changes
  void _saveProfile() async {
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    final ok = await _updCtrl.submit();

    // Hide loading indicator
    if (mounted) {
      Navigator.of(context).pop();
    }

    final msg = ok
        ? 'Profile updated successfully'
        : _updCtrl.errorMessage.value;

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: ok ? Colors.green : Colors.red,
        ),
      );
    }

    if (ok && mounted) {
      context.pop();
    }
  }

  /// Discard profile changes
  void _discardChanges() {
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Discard Changes'),
          content: const Text('Are you sure you want to discard your changes?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.pop();
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Discard'),
            ),
          ],
        );
      },
    );
  }

  /// Construct full image URL from relative or absolute path
  String _getFullImageUrl(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return '';
    }

    // If already a full URL (starts with http:// or https://), return as is
    if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
      return imageUrl;
    }

    // Remove leading slash if present
    final cleanPath = imageUrl.startsWith('/')
        ? imageUrl.substring(1)
        : imageUrl;

    // Construct full URL
    return '${ApiUrl.imageBaseUrl}/$cleanPath';
  }
}

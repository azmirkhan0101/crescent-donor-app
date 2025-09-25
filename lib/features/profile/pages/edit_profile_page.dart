import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

/// Edit Profile Page
///
/// This page allows users to edit their profile information including
/// name, phone number, email, address, state, and pin code.
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // Text controllers for form fields
  final _nameController = TextEditingController(text: 'Talha Shafqat');
  final _phoneController = TextEditingController(text: '87879 98900');
  final _emailController = TextEditingController(text: 'talha@gmail.com');
  final _addressController = TextEditingController(
    text: '1234 Elm Street Suite 205 Springfield, IL 2704, United States',
  );
  final _pinCodeController = TextEditingController(text: '94105');

  // Selected values for dropdowns
  final String _selectedCountryCode = '+1';
  final String _selectedState = 'New York';

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _pinCodeController.dispose();
    super.dispose();
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
          color: const Color(0xFF000C0B),
          letterSpacing: -0.2,
        ),
      ),
      centerTitle: true,
    );
  }

  /// Build profile avatar with edit button
  Widget _buildProfileAvatar() {
    return Stack(
      children: [
        // Main Avatar
        Container(
          width: 120.rw,
          height: 120.rh,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFEBE9EC), width: 1.714),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFC08FFF), Color(0xFF8B5CF6)],
            ),
          ),
          child: Center(
            child: Icon(
              Icons.person_outline,
              size: 60.rfs,
              color: Colors.white,
            ),
          ),
        ),

        // Edit Button
        Positioned(
          bottom: 0,
          right: 16.rw,
          child: Container(
            width: 24.rw,
            height: 24.rh,
            decoration: const BoxDecoration(
              color: Color(0xFF000C0B),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(
                Assets.common.add.path, // Using add icon as edit icon
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
      ],
    );
  }

  /// Build form fields section
  Widget _buildFormFields() {
    return Column(
      children: [
        // Name Field
        _buildInputField(label: 'Name', controller: _nameController),

        SizedBox(height: 16.rh),

        // Phone Number Field
        _buildPhoneNumberField(),

        SizedBox(height: 16.rh),

        // Email Field
        _buildInputField(label: 'Email', controller: _emailController),

        SizedBox(height: 16.rh),

        // Address Field
        _buildInputField(
          label: 'Address',
          controller: _addressController,
          maxLines: 3,
        ),

        SizedBox(height: 16.rh),

        // State and Pin Code Row
        _buildStateAndPinCodeRow(),
      ],
    );
  }

  /// Build individual input field
  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: DonationFonts.interDisplay,
            fontSize: 14.rfs,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF000C0B),
          ),
        ),

        SizedBox(height: 8.rh),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.rw),
            border: Border.all(color: const Color(0xFFE4E4E4), width: 1),
          ),
          child: TextFormField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.rw),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.all(16.rw),
            ),
            style: TextStyle(
              fontFamily: DonationFonts.interDisplay,
              fontSize: 14.rfs,
              fontWeight: maxLines > 1 ? FontWeight.w400 : FontWeight.w500,
              color: const Color(0xFF000C0B),
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
            fontSize: 14.rfs,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF000C0B),
          ),
        ),

        SizedBox(height: 8.rh),

        Container(
          height: 52.rh,
          padding: EdgeInsets.symmetric(horizontal: 16.rw),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.rw),
            border: Border.all(color: const Color(0xFFE4E4E4), width: 1),
          ),
          child: Row(
            children: [
              // Country Code Dropdown
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.rh),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _selectedCountryCode,
                      style: TextStyle(
                        fontFamily: DonationFonts.interDisplay,
                        fontSize: 14.rfs,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF000C0B),
                      ),
                    ),

                    SizedBox(width: 4.rw),

                    Transform.rotate(
                      angle: 1.5708, // 90 degrees to make arrow point down
                      child: SvgPicture.asset(
                        Assets.common.arrowLeft.path,
                        width: 16.rw,
                        height: 16.rh,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFF000C0B),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 8.rw),

              // Phone Number Input
              Expanded(
                child: TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: TextStyle(
                    fontFamily: DonationFonts.interDisplay,
                    fontSize: 14.rfs,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF000C0B),
                  ),
                ),
              ),
            ],
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
                  fontSize: 14.rfs,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF000C0B),
                ),
              ),

              SizedBox(height: 8.rh),

              Container(
                height: 52.rh,
                padding: EdgeInsets.symmetric(horizontal: 16.rw),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.rw),
                  border: Border.all(color: const Color(0xFFE4E4E4), width: 1),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedState,
                        style: TextStyle(
                          fontFamily: DonationFonts.interDisplay,
                          fontSize: 14.rfs,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF000C0B),
                        ),
                      ),
                    ),

                    Transform.rotate(
                      angle: 1.5708, // 90 degrees to make arrow point down
                      child: SvgPicture.asset(
                        Assets.common.arrowLeft.path,
                        width: 16.rw,
                        height: 16.rh,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFF000C0B),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(width: 16.rw),

        // Pin Code Field
        Expanded(
          child: _buildInputField(
            label: 'Pin Code',
            controller: _pinCodeController,
          ),
        ),
      ],
    );
  }

  /// Build action buttons (Save and Discard Changes)
  Widget _buildActionButtons() {
    return SizedBox(
      width: 263.rw,
      child: Column(
        children: [
          // Save Button
          SizedBox(
            width: double.infinity,
            height: 52.rh,
            child: ElevatedButton(
              onPressed: _saveProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD1FF43),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.rw),
                ),
              ),
              child: Text(
                'Save',
                style: TextStyle(
                  fontFamily: DonationFonts.familjenGrotesk,
                  fontSize: 18.rfs,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF000C0B),
                  letterSpacing: -0.36,
                ),
              ),
            ),
          ),

          SizedBox(height: 16.rh),

          // Discard Changes Button
          GestureDetector(
            onTap: _discardChanges,
            child: Text(
              'Discard Changes',
              style: TextStyle(
                fontFamily: DonationFonts.interDisplay,
                fontSize: 14.rfs,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF000C0B),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  /// Save profile changes
  void _saveProfile() {
    // TODO: Implement save functionality
    // For now, just show a success message and go back
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile updated successfully'),
        backgroundColor: Colors.green,
      ),
    );
    context.pop();
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
}

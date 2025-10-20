import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cresent_charge_user_app/common-widgets/custom_loader/custom_loader.dart';
import 'package:cresent_charge_user_app/features/auth/controllers/login_controller.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';

/// Example showing how to integrate CustomLoader with LoginController
class LoginPageWithCustomLoader extends StatelessWidget {
  LoginPageWithCustomLoader({super.key});

  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingOverlay(
        // Use LoginController's loading state
        isLoading: loginController.isLoading.value,
        message: 'Signing you in...',
        loaderType: LoaderType.wave,
        child: Padding(
          padding: EdgeInsets.all(20.rw),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Your login form fields here
              _buildLoginForm(),

              SizedBox(height: 24.rh),

              // Login button with integrated loading
              _buildLoginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        // Email field
        TextFormField(
          controller: loginController.emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
            prefixIcon: Icon(Icons.email),
          ),
        ),

        SizedBox(height: 16.rh),

        // Password field
        Obx(
          () => TextFormField(
            controller: loginController.passwordController,
            obscureText: !loginController.isPasswordVisible.value,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  loginController.isPasswordVisible.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: loginController.togglePasswordVisibility,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Obx(
      () => LoadingButton(
        onPressed: loginController.isLoading.value
            ? null
            : () => _handleLogin(),
        isLoading: loginController.isLoading.value,
        loaderColor: AppColors.white,
        backgroundColor: AppColors.primaryColor,
        padding: EdgeInsets.symmetric(horizontal: 32.rw, vertical: 16.rh),
        child: Text(
          'Sign In',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 16.rfs,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _handleLogin() async {
    if (loginController.formKey.currentState?.validate() ?? false) {
      await loginController.login();
    }
  }
}

/// Alternative approach: Using different loaders for different states
class LoginPageWithMultipleLoaders extends StatelessWidget {
  LoginPageWithMultipleLoaders({super.key});

  final LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.rw),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo or app branding
            _buildAppLogo(),

            SizedBox(height: 40.rh),

            // Login form
            _buildLoginForm(),

            SizedBox(height: 24.rh),

            // Different button states with different loaders
            _buildSmartLoginButton(),

            SizedBox(height: 16.rh),

            // Loading state indicator
            _buildLoadingStateIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppLogo() {
    return Container(
      height: 120.rh,
      width: 120.rw,
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(60.rw),
      ),
      child: Icon(Icons.flash_on, size: 60.rw, color: AppColors.primaryColor),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: loginController.formKey,
      child: Column(
        children: [
          TextFormField(
            controller: loginController.emailController,
            validator: loginController.validateEmail,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
            ),
          ),

          SizedBox(height: 16.rh),

          Obx(
            () => TextFormField(
              controller: loginController.passwordController,
              validator: loginController.validatePassword,
              obscureText: !loginController.isPasswordVisible.value,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    loginController.isPasswordVisible.value
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                  onPressed: loginController.togglePasswordVisibility,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmartLoginButton() {
    return Obx(() {
      // Different button states with appropriate loaders
      if (loginController.isLoading.value) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 16.rh),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(8.rw),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoadingIndicator.small(color: AppColors.white),
              SizedBox(width: 12.rw),
              Text(
                'Signing In...',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16.rfs,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      }

      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _handleLogin,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            padding: EdgeInsets.symmetric(vertical: 16.rh),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.rw),
            ),
          ),
          child: Text(
            'Sign In',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16.rfs,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    });
  }

  Widget _buildLoadingStateIndicator() {
    return Obx(() {
      if (!loginController.isLoading.value) {
        return const SizedBox.shrink();
      }

      return Column(
        children: [
          // Show different loaders based on loading progress
          LoadingIndicator.wave(color: AppColors.primaryColor),

          SizedBox(height: 12.rh),

          Text(
            'Authenticating your credentials...',
            style: TextStyle(fontSize: 14.rfs, color: AppColors.grayColor),
            textAlign: TextAlign.center,
          ),
        ],
      );
    });
  }

  void _handleLogin() async {
    if (loginController.formKey.currentState?.validate() ?? false) {
      await loginController.login();
    }
  }
}

/// Utility class for different loading scenarios
class LoginLoadingStates {
  /// Show loading for email validation
  static Widget emailValidationLoader() {
    return LoadingIndicator.small(color: AppColors.primaryColor);
  }

  /// Show loading for form submission
  static Widget formSubmissionLoader() {
    return LoadingIndicator.wave(color: AppColors.primaryColor);
  }

  /// Show loading for authentication
  static Widget authenticationLoader() {
    return const CustomLoader(
      type: LoaderType.fadingCube,
      color: AppColors.primaryColor,
    );
  }

  /// Show loading overlay for the entire login process
  static Widget loginOverlayLoader({required Widget child}) {
    return LoadingOverlay(
      isLoading: true,
      message: 'Please wait while we sign you in...',
      loaderType: LoaderType.pulse,
      backgroundColor: Colors.black.withValues(alpha: 0.3),
      child: child,
    );
  }
}

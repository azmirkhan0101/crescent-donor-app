import 'package:cresent_charge_user_app/common-widgets/form-fields/custom_text_field.dart';
import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomEmailField extends StatelessWidget {
  const CustomEmailField({
    super.key,
    required this.controller,
    this.label = 'Email',
    this.hintText = 'Enter Email Address',
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.enabled = true,
    this.autofocus = false,
    this.textInputAction = TextInputAction.next,
    this.errorText,
    this.helperText,
    this.focusNode,
    this.customValidator,
  });

  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final bool enabled;
  final bool autofocus;
  final TextInputAction textInputAction;
  final String? errorText;
  final String? helperText;
  final FocusNode? focusNode;
  final String? Function(String?)? customValidator;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      label: label,
      hintText: hintText,
      validator: validator ?? _defaultEmailValidator,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: TextInputType.emailAddress,
      textInputAction: textInputAction,
      enabled: enabled,
      autofocus: autofocus,
      errorText: errorText,
      helperText: helperText,
      focusNode: focusNode,
      textCapitalization: TextCapitalization.none,
      prefixIcon: Assets.onboarding.mail.svg(),
    );
  }

  /// Default email validator
  String? _defaultEmailValidator(String? value) {
    // Use custom validator if provided
    if (customValidator != null) {
      return customValidator!(value);
    }

    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }
}

/// Email Field Variants for common use cases

class SignupEmailField extends StatelessWidget {
  const SignupEmailField({
    super.key,
    required this.controller,
    this.onChanged,
    this.focusNode,
  });

  final TextEditingController controller;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return CustomEmailField(
      controller: controller,
      label: 'Email Address',
      hintText: 'Enter your email address',
      onChanged: onChanged,
      focusNode: focusNode,
      textInputAction: TextInputAction.next,
      helperText: 'We\'ll use this email for your account',
    );
  }
}

class LoginEmailField extends StatelessWidget {
  const LoginEmailField({
    super.key,
    required this.controller,
    this.onChanged,
    this.focusNode,
  });

  final TextEditingController controller;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return CustomEmailField(
      controller: controller,
      label: 'Email',
      hintText: 'Enter Email Address',
      onChanged: onChanged,
      focusNode: focusNode,
      textInputAction: TextInputAction.next,
      // helperText: 'Enter the email associated with your account',
    );
  }
}

class ForgotPasswordEmailField extends StatelessWidget {
  const ForgotPasswordEmailField({
    super.key,
    required this.controller,
    this.onChanged,
    this.focusNode,
  });

  final TextEditingController controller;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return CustomEmailField(
      controller: controller,
      label: 'Email Address',
      hintText: 'Enter your email address',
      onChanged: onChanged,
      focusNode: focusNode,
      textInputAction: TextInputAction.done,
      helperText: 'Enter the email associated with your account',
    );
  }
}

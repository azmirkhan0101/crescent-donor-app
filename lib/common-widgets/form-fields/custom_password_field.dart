import 'package:cresent_charge_user_app/common-widgets/form-fields/custom_text_field.dart';
import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:flutter/material.dart';

import '../../core/helper/extension/context_extension.dart';

class CustomPasswordField extends StatefulWidget {
  const CustomPasswordField({
    super.key,
    required this.controller,
    this.label = 'Password',
    this.hintText,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.enabled = true,
    this.autofocus = false,
    this.textInputAction = TextInputAction.done,
    this.errorText,
    this.helperText,
    this.focusNode,
    this.customValidator,
    this.showVisibilityToggle = true,
    this.initiallyObscured = true,
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
  final bool showVisibilityToggle;
  final bool initiallyObscured;

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.initiallyObscured;
  }

  void _toggleVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: widget.controller,
      label: widget.label,
      hintText: widget.hintText ?? '***********',
      validator: widget.validator ?? _defaultPasswordValidator,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: widget.textInputAction,
      obscureText: _isObscured,
      enabled: widget.enabled,
      autofocus: widget.autofocus,
      errorText: widget.errorText,
      helperText: widget.helperText,
      focusNode: widget.focusNode,
      textCapitalization: TextCapitalization.none,
      prefixIcon: Assets.onboarding.lock.svg(),
      suffixIcon: widget.showVisibilityToggle
          ? GestureDetector(
              onTap: _toggleVisibility,
              child: _isObscured
                  ? Assets.common.showPassword.svg()
                  : Assets.common.hidePassword.svg(),
              // child: Icon(
              //   _isObscured ? Icons.visibility_off : Icons.visibility,
              //   color: AppColors.black.withValues(alpha: 0.6),
              //   size: 20.rw,
              // ),
            )
          : null,
    );
  }

  /// Default password validator
  String? _defaultPasswordValidator(String? value) {
    // Use custom validator if provided
    if (widget.customValidator != null) {
      return widget.customValidator!(value);
    }

    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    return null;
  }
}

/// Password Field Variants for common use cases

class LoginPasswordField extends StatelessWidget {
  const LoginPasswordField({
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
    return CustomPasswordField(
      controller: controller,
      label: 'Password',
      hintText: '***********',
      onChanged: onChanged,
      focusNode: focusNode,
      textInputAction: TextInputAction.done,
    );
  }
}

class SignupPasswordField extends StatelessWidget {
  const SignupPasswordField({
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
    return CustomPasswordField(
      controller: controller,
      label: 'Create Password',
      hintText: 'Enter a strong password',
      onChanged: onChanged,
      focusNode: focusNode,
      textInputAction: TextInputAction.next,
      customValidator: _strongPasswordValidator,
      helperText:
          'Must be at least 8 characters with uppercase, lowercase, number & special character',
    );
  }

  /// Strong password validator for signup
  String? _strongPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    return null;
  }
}

class ConfirmPasswordField extends StatelessWidget {
  const ConfirmPasswordField({
    super.key,
    required this.controller,
    required this.passwordController,
    this.onChanged,
    this.focusNode,
  });

  final TextEditingController controller;
  final TextEditingController passwordController;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return CustomPasswordField(
      controller: controller,
      label: 'Confirm Password',
      hintText: 'Re-enter your password',
      onChanged: onChanged,
      focusNode: focusNode,
      textInputAction: TextInputAction.done,
      customValidator: _confirmPasswordValidator,
      helperText: 'Enter the same password as above',
    );
  }

  /// Confirm password validator
  String? _confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != passwordController.text) {
      return 'Passwords do not match';
    }

    return null;
  }
}

class NewPasswordField extends StatelessWidget {
  const NewPasswordField({
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
    return CustomPasswordField(
      controller: controller,
      label: 'New Password',
      hintText: 'Enter new password',
      onChanged: onChanged,
      focusNode: focusNode,
      textInputAction: TextInputAction.next,
      customValidator: _strongPasswordValidator,
      helperText: 'Create a strong password for your account',
    );
  }

  /// Strong password validator
  String? _strongPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'New password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    return null;
  }
}

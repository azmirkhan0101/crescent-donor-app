# 📝 Reusable Form Field Widgets

This document explains the reusable form field widgets created for consistent UI and functionality across the entire project.

## 🏗️ Architecture Overview

The form field widgets follow a hierarchical structure:

```
CustomTextField (Base)
├── CustomEmailField (Email-specific)
├── CustomPasswordField (Password-specific)
└── Future: CustomPhoneField, CustomNumericField, etc.
```

## 📦 Components

### 1. CustomTextField (Base Widget)

**Location**: `lib/common-widgets/form-fields/custom_text_field.dart`

The foundation widget that provides all common text field functionality.

#### Key Features

- ✅ **Full Validation Support**: Custom validators with error display
- ✅ **Flexible Styling**: Customizable colors, borders, padding
- ✅ **Label & Hint Support**: Optional labels and hint text
- ✅ **Icon Support**: Prefix and suffix icons
- ✅ **Input Controls**: Text formatters, input types, actions
- ✅ **Accessibility**: Focus nodes, keyboard handling
- ✅ **Error Handling**: Built-in error text display

#### Usage Example

```dart
CustomTextField(
  controller: nameController,
  label: 'Full Name',
  hintText: 'Enter your full name',
  validator: (value) => value?.isEmpty == true ? 'Name is required' : null,
  prefixIcon: Icon(Icons.person),
  keyboardType: TextInputType.name,
  textInputAction: TextInputAction.next,
)
```

#### Parameters

- `controller` (required): TextEditingController
- `label`: Optional field label
- `hintText`: Placeholder text
- `validator`: Validation function
- `onChanged`: Text change callback
- `keyboardType`: Input keyboard type
- `prefixIcon`/`suffixIcon`: Optional icons
- `enabled`, `readOnly`, `autofocus`: Control states
- `maxLines`, `minLines`, `maxLength`: Text constraints
- `fillColor`, `borderRadius`: Styling options

### 2. CustomEmailField

**Location**: `lib/common-widgets/form-fields/custom_email_field.dart`

Email-specific input field with built-in validation and email icon.

#### Key Features

- ✅ **Email Validation**: Built-in email format validation
- ✅ **Email Icon**: Pre-configured mail icon
- ✅ **Email Keyboard**: Automatic email keyboard type
- ✅ **Variants**: Pre-built variants for different contexts

#### Usage Examples

**Basic Email Field:**

```dart
CustomEmailField(
  controller: emailController,
  onChanged: (value) => print('Email: $value'),
)
```

**Custom Validation:**

```dart
CustomEmailField(
  controller: emailController,
  customValidator: (value) {
    if (value?.contains('company.com') != true) {
      return 'Please use your company email';
    }
    return null;
  },
)
```

#### Pre-built Variants

**LoginEmailField:**

```dart
LoginEmailField(
  controller: emailController,
  onChanged: (value) => clearError(),
)
```

**SignupEmailField:**

```dart
SignupEmailField(
  controller: emailController,
  focusNode: emailFocusNode,
)
```

**ForgotPasswordEmailField:**

```dart
ForgotPasswordEmailField(
  controller: emailController,
)
```

### 3. CustomPasswordField

**Location**: `lib/common-widgets/form-fields/custom_password_field.dart`

Password input field with visibility toggle and strong validation.

#### Key Features

- ✅ **Visibility Toggle**: Show/hide password functionality
- ✅ **Strong Validation**: Password strength requirements
- ✅ **Lock Icon**: Pre-configured lock icon
- ✅ **Security**: Secure text input
- ✅ **Variants**: Different validation levels

#### Usage Examples

**Basic Password Field:**

```dart
CustomPasswordField(
  controller: passwordController,
  onChanged: (value) => validatePassword(value),
)
```

**Custom Validation:**

```dart
CustomPasswordField(
  controller: passwordController,
  customValidator: (value) {
    if (value?.length < 8) return 'Too short';
    return null;
  },
  showVisibilityToggle: true,
  initiallyObscured: true,
)
```

#### Pre-built Variants

**LoginPasswordField:**

```dart
LoginPasswordField(
  controller: passwordController,
)
```

**SignupPasswordField (Strong Validation):**

```dart
SignupPasswordField(
  controller: passwordController,
  focusNode: passwordFocusNode,
)
```

**ConfirmPasswordField:**

```dart
ConfirmPasswordField(
  controller: confirmController,
  passwordController: passwordController,
)
```

**NewPasswordField:**

```dart
NewPasswordField(
  controller: newPasswordController,
)
```

## 🎯 Validation Features

### Email Validation

```dart
// Default validation
- Required field
- Valid email format using GetUtils.isEmail()

// Custom validation support
customValidator: (value) {
  if (value?.endsWith('@company.com') != true) {
    return 'Use company email only';
  }
  return null;
}
```

### Password Validation

#### Basic (Login)

- Required field
- Minimum 6 characters

#### Strong (Signup/New Password)

- Minimum 8 characters
- At least one uppercase letter (A-Z)
- At least one lowercase letter (a-z)
- At least one number (0-9)
- At least one special character (!@#$%^&*)

#### Confirm Password

- Matches original password
- Required field

## 📱 UI/UX Features

### Consistent Styling

- **Border Radius**: 12px rounded corners
- **Colors**: Primary color focus, red color errors
- **Typography**: Inter font family
- **Spacing**: Consistent padding and margins
- **Icons**: Material icons with proper sizing

### Interactive States

- **Default**: Light gray border
- **Focused**: Primary color border
- **Error**: Red border with error message
- **Disabled**: Muted colors and disabled interaction

### Responsive Design

- Uses `ScreenUtil` extensions (.rw, .rh, .rfs)
- Adapts to different screen sizes
- Consistent spacing across devices

## 🔧 Integration Guide

### Import

```dart
import 'package:donor/common-widgets/form-fields/form_fields.dart';
```

### Form Integration

```dart
class MyForm extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          LoginEmailField(
            controller: emailController,
          ),
          
          SizedBox(height: 16),
          
          LoginPasswordField(
            controller: passwordController,
          ),
          
          SizedBox(height: 24),
          
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState?.validate() == true) {
                // Process form
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
```

### Controller Integration

```dart
class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  void submitForm() {
    if (validateForm()) {
      // Process login
      login(emailController.text, passwordController.text);
    }
  }
}
```

## 🎨 Customization Examples

### Custom Styling

```dart
CustomTextField(
  controller: controller,
  fillColor: Colors.grey[100],
  borderRadius: BorderRadius.circular(8),
  contentPadding: EdgeInsets.all(20),
)
```

### Custom Icons

```dart
CustomTextField(
  controller: controller,
  prefixIcon: Icon(Icons.search),
  suffixIcon: IconButton(
    icon: Icon(Icons.clear),
    onPressed: () => controller.clear(),
  ),
)
```

### Custom Validation

```dart
CustomTextField(
  controller: controller,
  validator: (value) {
    if (value?.isEmpty == true) return 'Required';
    if (value!.length < 3) return 'Too short';
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Only letters allowed';
    }
    return null;
  },
)
```

## 🚀 Benefits

### For Developers

- **Consistency**: Same look and behavior across the app
- **Productivity**: Pre-built components save development time
- **Maintainability**: Single source of truth for form styling
- **Reusability**: Use same components in different contexts
- **Type Safety**: Strong typing with Flutter's type system

### For Users

- **Familiar UI**: Consistent form experience
- **Better UX**: Proper validation and error messages
- **Accessibility**: Built-in focus management and keyboard handling
- **Responsive**: Works well on all screen sizes

### For QA

- **Predictable**: Same validation logic across the app
- **Testable**: Well-defined component boundaries
- **Reliable**: Thoroughly tested base components

## 📈 Usage Patterns

### Login Page

```dart
Column(
  children: [
    LoginEmailField(controller: emailController),
    SizedBox(height: 16),
    LoginPasswordField(controller: passwordController),
  ],
)
```

### Signup Page

```dart
Column(
  children: [
    SignupEmailField(controller: emailController),
    SizedBox(height: 16),
    SignupPasswordField(controller: passwordController),
    SizedBox(height: 16),
    ConfirmPasswordField(
      controller: confirmController,
      passwordController: passwordController,
    ),
  ],
)
```

### Profile Edit

```dart
Column(
  children: [
    CustomTextField(
      controller: nameController,
      label: 'Full Name',
      prefixIcon: Icon(Icons.person),
    ),
    SizedBox(height: 16),
    CustomEmailField(
      controller: emailController,
      enabled: false, // Disable email editing
    ),
  ],
)
```

### Search Fields

```dart
CustomTextField(
  controller: searchController,
  hintText: 'Search...',
  prefixIcon: Icon(Icons.search),
  suffixIcon: IconButton(
    icon: Icon(Icons.clear),
    onPressed: () => searchController.clear(),
  ),
  onChanged: (value) => performSearch(value),
)
```

## 🔄 Migration Guide

### From Existing CustomInputField

**Before:**

```dart
CustomInputField(
  controller: controller,
  hintText: "Enter Email",
  prefixIcon: Assets.onboarding.mail.svg(),
  keyboardType: TextInputType.emailAddress,
)
```

**After:**

```dart
LoginEmailField(
  controller: controller,
)
```

### Benefits of Migration

- ✅ Built-in validation
- ✅ Consistent styling
- ✅ Better error handling
- ✅ Less boilerplate code
- ✅ Type-specific features

## 🎯 Summary

The reusable form field widgets provide:

✅ **CustomTextField** - Base widget with full customization
✅ **CustomEmailField** - Email-specific with validation and variants
✅ **CustomPasswordField** - Password-specific with security features
✅ **Pre-built Variants** - Ready-to-use components for common scenarios
✅ **Consistent Styling** - Unified design across the app
✅ **Strong Validation** - Built-in and customizable validation
✅ **Better UX** - Proper error handling and user feedback
✅ **Easy Integration** - Simple import and usage
✅ **Maintainable Code** - Single source of truth for form components

These widgets can now be used throughout your entire project for consistent, validated, and beautiful form inputs! 🚀

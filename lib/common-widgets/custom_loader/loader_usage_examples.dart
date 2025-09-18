import 'package:flutter/material.dart';
import 'package:cresent_charge_user_app/common-widgets/custom_loader/custom_loader.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';

/// Example page demonstrating various usage patterns of CustomLoader
class LoaderExamplesPage extends StatefulWidget {
  const LoaderExamplesPage({super.key});

  @override
  State<LoaderExamplesPage> createState() => _LoaderExamplesPageState();
}

class _LoaderExamplesPageState extends State<LoaderExamplesPage> {
  bool _isLoading = false;
  bool _isButtonLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Loader Examples'),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
      ),
      body: LoadingOverlay(
        isLoading: _isLoading,
        message: 'Processing your request...',
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.rw),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Basic Loaders'),
              _buildBasicLoaders(),
              SizedBox(height: 24.rh),

              _buildSectionTitle('Pre-built Loader Variants'),
              _buildPrebuiltLoaders(),
              SizedBox(height: 24.rh),

              _buildSectionTitle('Custom Configurations'),
              _buildCustomLoaders(),
              SizedBox(height: 24.rh),

              _buildSectionTitle('Interactive Examples'),
              _buildInteractiveExamples(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.rh),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.rfs,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
      ),
    );
  }

  Widget _buildBasicLoaders() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.rw),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const CustomLoader(type: LoaderType.circle),
                    SizedBox(height: 8.rh),
                    Text('Circle', style: TextStyle(fontSize: 12.rfs)),
                  ],
                ),
                Column(
                  children: [
                    const CustomLoader(type: LoaderType.doubleBounce),
                    SizedBox(height: 8.rh),
                    Text('Double Bounce', style: TextStyle(fontSize: 12.rfs)),
                  ],
                ),
                Column(
                  children: [
                    const CustomLoader(type: LoaderType.wave),
                    SizedBox(height: 8.rh),
                    Text('Wave', style: TextStyle(fontSize: 12.rfs)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.rh),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const CustomLoader(type: LoaderType.fadingCube),
                    SizedBox(height: 8.rh),
                    Text('Fading Cube', style: TextStyle(fontSize: 12.rfs)),
                  ],
                ),
                Column(
                  children: [
                    const CustomLoader(type: LoaderType.pulse),
                    SizedBox(height: 8.rh),
                    Text('Pulse', style: TextStyle(fontSize: 12.rfs)),
                  ],
                ),
                Column(
                  children: [
                    const CustomLoader(type: LoaderType.threeBounce),
                    SizedBox(height: 8.rh),
                    Text('Three Bounce', style: TextStyle(fontSize: 12.rfs)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrebuiltLoaders() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.rw),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    LoadingIndicator.primary(),
                    SizedBox(height: 8.rh),
                    Text('Primary', style: TextStyle(fontSize: 12.rfs)),
                  ],
                ),
                Column(
                  children: [
                    LoadingIndicator.secondary(),
                    SizedBox(height: 8.rh),
                    Text('Secondary', style: TextStyle(fontSize: 12.rfs)),
                  ],
                ),
                Column(
                  children: [
                    LoadingIndicator.elegant(),
                    SizedBox(height: 8.rh),
                    Text('Elegant', style: TextStyle(fontSize: 12.rfs)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.rh),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    LoadingIndicator.wave(),
                    SizedBox(height: 8.rh),
                    Text('Wave', style: TextStyle(fontSize: 12.rfs)),
                  ],
                ),
                Column(
                  children: [
                    LoadingIndicator.pulse(),
                    SizedBox(height: 8.rh),
                    Text('Pulse', style: TextStyle(fontSize: 12.rfs)),
                  ],
                ),
                Column(
                  children: [
                    LoadingIndicator.ripple(),
                    SizedBox(height: 8.rh),
                    Text('Ripple', style: TextStyle(fontSize: 12.rfs)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomLoaders() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.rw),
        child: Column(
          children: [
            Text(
              'Custom Colors & Sizes',
              style: TextStyle(fontSize: 14.rfs, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 12.rh),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    CustomLoader(
                      type: LoaderType.circle,
                      color: Colors.red,
                      size: 30.rw,
                    ),
                    SizedBox(height: 8.rh),
                    Text('Small Red', style: TextStyle(fontSize: 12.rfs)),
                  ],
                ),
                Column(
                  children: [
                    CustomLoader(
                      type: LoaderType.doubleBounce,
                      color: Colors.green,
                      size: 50.rw,
                    ),
                    SizedBox(height: 8.rh),
                    Text('Medium Green', style: TextStyle(fontSize: 12.rfs)),
                  ],
                ),
                Column(
                  children: [
                    CustomLoader(
                      type: LoaderType.fadingCube,
                      color: Colors.purple,
                      size: 70.rw,
                    ),
                    SizedBox(height: 8.rh),
                    Text('Large Purple', style: TextStyle(fontSize: 12.rfs)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveExamples() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.rw),
        child: Column(
          children: [
            LoadingButton(
              onPressed: () {
                setState(() {
                  _isButtonLoading = true;
                });
                Future.delayed(const Duration(seconds: 3), () {
                  setState(() {
                    _isButtonLoading = false;
                  });
                });
              },
              isLoading: _isButtonLoading,
              child: Text(
                'Loading Button',
                style: TextStyle(color: AppColors.white, fontSize: 16.rfs),
              ),
            ),
            SizedBox(height: 16.rh),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isLoading = true;
                });
                Future.delayed(const Duration(seconds: 3), () {
                  setState(() {
                    _isLoading = false;
                  });
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: AppColors.white,
              ),
              child: const Text('Show Loading Overlay'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Example of using loaders in different contexts
class LoaderUsageExamples {
  /// Example 1: Simple loading in widget
  static Widget simpleLoader() {
    return const CustomLoader(type: LoaderType.circle);
  }

  /// Example 2: Custom colored loader
  static Widget customColorLoader() {
    return const CustomLoader(
      type: LoaderType.doubleBounce,
      color: Colors.blue,
      size: 60,
    );
  }

  /// Example 3: Using pre-built variants
  static Widget primaryLoader() {
    return LoadingIndicator.primary();
  }

  /// Example 4: Loading overlay usage
  static Widget withLoadingOverlay({
    required Widget child,
    required bool isLoading,
  }) {
    return LoadingOverlay(
      isLoading: isLoading,
      message: 'Please wait...',
      child: child,
    );
  }

  /// Example 5: Loading button usage
  static Widget loadingButton({
    required VoidCallback onPressed,
    required bool isLoading,
  }) {
    return LoadingButton(
      onPressed: onPressed,
      isLoading: isLoading,
      child: const Text('Submit'),
    );
  }

  /// Example 6: Different loader types
  static Widget loaderGrid() {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      children: LoaderType.values.map((type) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomLoader(type: type, size: 40),
            const SizedBox(height: 8),
            Text(
              type.name,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        );
      }).toList(),
    );
  }
}

/// Best practices for using loaders
class LoaderBestPractices {
  /// Use appropriate loader size for context
  static Widget contextAwareLoader(BuildContext context) {
    // Use different sizes based on available space
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 400) {
      return LoadingIndicator.small();
    } else if (screenWidth < 800) {
      return LoadingIndicator.primary();
    } else {
      return LoadingIndicator.large();
    }
  }

  /// Color coordination with app theme
  static Widget themedLoader(BuildContext context) {
    final theme = Theme.of(context);

    return CustomLoader(type: LoaderType.circle, color: theme.primaryColor);
  }

  /// Performance optimized loader
  static Widget optimizedLoader() {
    return const CustomLoader(
      type: LoaderType.threeBounce, // Lightweight animation
      duration: Duration(milliseconds: 800), // Faster animation
    );
  }
}

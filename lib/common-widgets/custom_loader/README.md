# Custom Loader with SpinKit Integration

A comprehensive, customizable loading widget system built on top of the [flutter_spinkit](https://pub.dev/packages/flutter_spinkit) package, providing various spinner animations with consistent styling and easy integration.

## Features

- 🎨 **15+ SpinKit Animation Types**: Choose from circle, wave, pulse, and many more
- 🎯 **Pre-built Variants**: Ready-to-use loaders for common scenarios
- 📱 **Responsive Design**: Automatically adapts to screen sizes using ScreenUtil
- 🔧 **Highly Customizable**: Control color, size, duration, and animation type
- 🚀 **Performance Optimized**: Lightweight animations with configurable durations
- 📦 **Complete Widget Suite**: Overlay, button, and standalone loader components

## Installation

The `flutter_spinkit` dependency is already included in your `pubspec.yaml`:

```yaml
dependencies:
  flutter_spinkit: ^5.2.2
```

## Available Loader Types

```dart
enum LoaderType {
  circle,           // Classic circular spinner
  doubleBounce,     // Two bouncing dots
  wave,             // Wave animation
  wanderingCubes,   // Moving cubes
  fadingFour,       // Four fading dots
  fadingCube,       // Fading cube animation
  pulse,            // Pulsing circle
  chasingDots,      // Chasing dots in circle
  threeBounce,      // Three bouncing dots
  rotatingCircle,   // Rotating circle
  foldingCube,      // Folding cube animation
  cubeGrid,         // Grid of cubes
  dualRing,         // Dual ring spinner
  ripple,           // Ripple effect
  spinningLines,    // Spinning lines
}
```

## Basic Usage

### Simple Loader

```dart
import 'package:donor/common-widgets/custom_loader/custom_loader.dart';

// Basic loader with default settings
const CustomLoader()

// Specific loader type
const CustomLoader(type: LoaderType.circle)

// Custom color and size
CustomLoader(
  type: LoaderType.wave,
  color: Colors.blue,
  size: 60.0,
)

// Custom duration
CustomLoader(
  type: LoaderType.pulse,
  duration: Duration(milliseconds: 800),
)
```

### Pre-built Loader Variants

```dart
// Primary loader (circle, primary color, 60px)
LoadingIndicator.primary()

// Secondary loader (doubleBounce, secondary color, 40px)
LoadingIndicator.secondary()

// Small loader for buttons (threeBounce, 20px)
LoadingIndicator.small()

// Large loader for full screen (fadingCube, 80px)
LoadingIndicator.large()

// Elegant loader for premium features (fadingCube, 50px)
LoadingIndicator.elegant()

// Wave loader for data processing
LoadingIndicator.wave()

// Pulse loader for heartbeat-like animations
LoadingIndicator.pulse()

// Ripple loader for expanding effects
LoadingIndicator.ripple()
```

## Advanced Usage

### Full Screen Loading Overlay

```dart
import 'package:donor/common-widgets/custom_loader/custom_loader.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      message: 'Processing your request...',
      loaderType: LoaderType.fadingCube,
      backgroundColor: Colors.black.withOpacity(0.5),
      child: Scaffold(
        // Your page content here
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() => _isLoading = true);
                // Simulate API call
                Future.delayed(Duration(seconds: 3), () {
                  setState(() => _isLoading = false);
                });
              },
              child: Text('Start Loading'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Loading Button

```dart
import 'package:donor/common-widgets/custom_loader/custom_loader.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Your form fields here
        
        LoadingButton(
          onPressed: _isSubmitting ? null : _handleSubmit,
          isLoading: _isSubmitting,
          loaderColor: Colors.white,
          backgroundColor: AppColors.primaryColor,
          child: Text(
            'Submit',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  void _handleSubmit() {
    setState(() => _isSubmitting = true);
    
    // Simulate form submission
    Future.delayed(Duration(seconds: 2), () {
      setState(() => _isSubmitting = false);
      // Handle response
    });
  }
}
```

## Integration Examples

### In Controllers (GetX)

```dart
import 'package:get/get.dart';

class DataController extends GetxController {
  var isLoading = false.obs;
  
  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      // API call here
      await apiService.getData();
    } finally {
      isLoading.value = false;
    }
  }
}

// In your widget
class DataPage extends StatelessWidget {
  final DataController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return LoadingIndicator.primary();
        }
        
        return YourContentWidget();
      }),
    );
  }
}
```

### With FutureBuilder

```dart
class AsyncDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Data>(
      future: fetchDataFromApi(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingIndicator.wave();
        }
        
        if (snapshot.hasError) {
          return ErrorWidget(snapshot.error!);
        }
        
        return DataDisplayWidget(data: snapshot.data!);
      },
    );
  }
}
```

### Custom Loader in Dialogs

```dart
void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LoadingIndicator.elegant(),
              SizedBox(height: 16),
              Text(
                'Please wait...',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      );
    },
  );
}
```

## Customization Options

### Color Schemes

```dart
// Primary brand color
CustomLoader(color: AppColors.primaryColor)

// Success state
CustomLoader(color: Colors.green)

// Warning state
CustomLoader(color: Colors.orange)

// Error state
CustomLoader(color: AppColors.redColor)

// Theme-based color
CustomLoader(color: Theme.of(context).primaryColor)
```

### Size Variations

```dart
// Extra small (for inline text)
CustomLoader(size: 16.0)

// Small (for buttons)
CustomLoader(size: 24.0)

// Medium (default)
CustomLoader(size: 50.0)

// Large (for main loading)
CustomLoader(size: 80.0)

// Extra large (for splash screens)
CustomLoader(size: 120.0)
```

### Animation Speed

```dart
// Fast animation
CustomLoader(duration: Duration(milliseconds: 600))

// Normal speed (default)
CustomLoader(duration: Duration(milliseconds: 1200))

// Slow animation
CustomLoader(duration: Duration(milliseconds: 2000))
```

## Best Practices

### 1. Choose Appropriate Loader Types

```dart
// For quick actions (< 2 seconds)
LoadingIndicator.small()

// For medium actions (2-5 seconds)
LoadingIndicator.primary()

// For long actions (> 5 seconds)
LoadingIndicator.wave() // More engaging for longer waits
```

### 2. Performance Considerations

```dart
// Use lightweight loaders for frequently shown animations
const CustomLoader(
  type: LoaderType.threeBounce,
  duration: Duration(milliseconds: 800),
)

// Avoid heavy animations in lists or frequently rebuilt widgets
```

### 3. User Experience Guidelines

```dart
// Always provide context for long operations
LoadingOverlay(
  isLoading: true,
  message: 'Uploading your photo...', // Specific message
  child: YourWidget(),
)

// Use appropriate colors for different states
CustomLoader(
  color: isError ? Colors.red : AppColors.primaryColor,
)
```

### 4. Accessibility

```dart
// Add semantic labels for screen readers
Semantics(
  label: 'Loading content',
  child: LoadingIndicator.primary(),
)
```

## File Structure

```
lib/common-widgets/custom_loader/
├── custom_loader.dart              # Main loader widget with all components
└── loader_usage_examples.dart      # Example implementations and demos
```

## Available Components

1. **CustomLoader**: Main configurable loader widget
2. **LoadingIndicator**: Pre-built loader variants
3. **LoadingOverlay**: Full-screen overlay with loader
4. **LoadingButton**: Button with integrated loading state

## Migration from Old Loader

If you're replacing an old loader implementation:

```dart
// Old usage
CircularProgressIndicator()

// New usage
LoadingIndicator.primary()

// Old custom usage
CircularProgressIndicator(
  color: Colors.blue,
  strokeWidth: 3.0,
)

// New custom usage
CustomLoader(
  type: LoaderType.circle,
  color: Colors.blue,
  size: 50.0,
)
```

## Support

For additional loader types or custom implementations, refer to the [flutter_spinkit documentation](https://pub.dev/packages/flutter_spinkit) or extend the `LoaderType` enum with additional SpinKit widgets.

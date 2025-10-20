import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';

/// Custom loader widget with various SpinKit animations
class CustomLoader extends StatelessWidget {
  const CustomLoader({
    super.key,
    this.type = LoaderType.circle,
    this.size,
    this.color,
    this.duration,
  });

  final LoaderType type;
  final double? size;
  final Color? color;
  final Duration? duration;

  @override
  Widget build(BuildContext context) {
    final Color loaderColor = color ?? AppColors.primaryColor;
    final double loaderSize = size ?? 50.0.rw;
    final Duration animationDuration =
        duration ?? const Duration(milliseconds: 1200);

    return Center(
      child: _buildSpinKitLoader(
        type: type,
        color: loaderColor,
        size: loaderSize,
        duration: animationDuration,
      ),
    );
  }

  Widget _buildSpinKitLoader({
    required LoaderType type,
    required Color color,
    required double size,
    required Duration duration,
  }) {
    switch (type) {
      case LoaderType.circle:
        return SpinKitCircle(color: color, size: size, duration: duration);
      case LoaderType.doubleBounce:
        return SpinKitDoubleBounce(
          color: color,
          size: size,
          duration: duration,
        );
      case LoaderType.wave:
        return SpinKitWave(color: color, size: size, duration: duration);
      case LoaderType.wanderingCubes:
        return SpinKitWanderingCubes(
          color: color,
          size: size,
          duration: duration,
        );
      case LoaderType.fadingFour:
        return SpinKitFadingFour(color: color, size: size, duration: duration);
      case LoaderType.fadingCube:
        return SpinKitFadingCube(color: color, size: size, duration: duration);
      case LoaderType.pulse:
        return SpinKitPulse(color: color, size: size, duration: duration);
      case LoaderType.chasingDots:
        return SpinKitChasingDots(color: color, size: size, duration: duration);
      case LoaderType.threeBounce:
        return SpinKitThreeBounce(color: color, size: size, duration: duration);
      case LoaderType.rotatingCircle:
        return SpinKitRotatingCircle(
          color: color,
          size: size,
          duration: duration,
        );
      case LoaderType.foldingCube:
        return SpinKitFoldingCube(color: color, size: size, duration: duration);
      case LoaderType.cubeGrid:
        return SpinKitCubeGrid(color: color, size: size, duration: duration);
      case LoaderType.dualRing:
        return SpinKitDualRing(color: color, size: size, duration: duration);
      case LoaderType.ripple:
        return SpinKitRipple(color: color, size: size, duration: duration);
      case LoaderType.spinningLines:
        return SpinKitSpinningLines(
          color: color,
          size: size,
          duration: duration,
        );
    }
  }
}

/// Enum for different loader types
enum LoaderType {
  circle,
  doubleBounce,
  wave,
  wanderingCubes,
  fadingFour,
  fadingCube,
  pulse,
  chasingDots,
  threeBounce,
  rotatingCircle,
  foldingCube,
  cubeGrid,
  dualRing,
  ripple,
  spinningLines,
}

/// Pre-built loader variants for common use cases
class LoadingIndicator {
  LoadingIndicator._();

  /// Primary loader for main app loading
  static Widget primary({double? size}) {
    return CustomLoader(
      type: LoaderType.circle,
      color: AppColors.primaryColor,
      size: size ?? 60.0.rw,
    );
  }

  /// Secondary loader for smaller components
  static Widget secondary({double? size}) {
    return CustomLoader(
      type: LoaderType.doubleBounce,
      color: AppColors.secondaryColor,
      size: size ?? 40.0.rw,
    );
  }

  /// Small loader for buttons and small spaces
  static Widget small({Color? color}) {
    return CustomLoader(
      type: LoaderType.threeBounce,
      color: color ?? AppColors.white,
      size: 20.0.rw,
    );
  }

  /// Large loader for full screen loading
  static Widget large({Color? color}) {
    return CustomLoader(
      type: LoaderType.fadingCube,
      color: color ?? AppColors.primaryColor,
      size: 80.0.rw,
    );
  }

  /// Elegant loader for premium features
  static Widget elegant({Color? color}) {
    return CustomLoader(
      type: LoaderType.fadingCube,
      color: color ?? AppColors.primaryColor,
      size: 50.0.rw,
    );
  }

  /// Wave loader for data processing
  static Widget wave({Color? color}) {
    return CustomLoader(
      type: LoaderType.wave,
      color: color ?? AppColors.primaryColor,
      size: 50.0.rw,
    );
  }

  /// Pulse loader for heartbeat-like animations
  static Widget pulse({Color? color}) {
    return CustomLoader(
      type: LoaderType.pulse,
      color: color ?? AppColors.primaryColor,
      size: 50.0.rw,
    );
  }

  /// Ripple loader for expanding effects
  static Widget ripple({Color? color}) {
    return CustomLoader(
      type: LoaderType.ripple,
      color: color ?? AppColors.primaryColor,
      size: 50.0.rw,
    );
  }
}

/// Full screen loading overlay
class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.loaderType = LoaderType.circle,
    this.backgroundColor,
    this.loaderColor,
    this.message,
  });

  final bool isLoading;
  final Widget child;
  final LoaderType loaderType;
  final Color? backgroundColor;
  final Color? loaderColor;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: backgroundColor ?? Colors.black.withValues(alpha: 0.3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomLoader(
                  type: loaderType,
                  color: loaderColor,
                  size: 60.0.rw,
                ),
                if (message != null) ...[
                  SizedBox(height: 20.rh),
                  Text(
                    message!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.rfs,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
      ],
    );
  }
}

/// Loading button with integrated spinner
class LoadingButton extends StatelessWidget {
  const LoadingButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.isLoading = false,
    this.loaderColor,
    this.backgroundColor,
    this.padding,
    this.borderRadius,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final bool isLoading;
  final Color? loaderColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primaryColor,
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 24.rw, vertical: 12.rh),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(8.rw),
        ),
      ),
      child: isLoading
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                LoadingIndicator.small(color: loaderColor ?? AppColors.white),
                SizedBox(width: 8.rw),
                Text(
                  'Loading...',
                  style: TextStyle(color: AppColors.white, fontSize: 14.rfs),
                ),
              ],
            )
          : child,
    );
  }
}

// import 'package:cresent_charge_user_app/gen/assets.gen.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:cresent_charge_user_app/core/routes/route_path.dart';
import 'package:google_fonts/google_fonts.dart';

extension RouteBasePathExt on String {
  String get addBasePath {
    return RoutePath.basePath + this;
  }
}

// extension ApiBasePathExt on String {
//   String get addBaseUrl {
//     return ApiUrl.baseUrl + this;
//   }
// }

extension HeightWidthExt on int {
  Widget get heightWidth {
    return Gap(toDouble());
  }
}

extension HeightWidthDoubleExt on double {
  Widget get heightWidth {
    return Gap(this);
  }
}

extension AspectRatioOnWidgetExt on Widget {
  Widget aspectRatio(double width, double height) {
    return AspectRatio(aspectRatio: width / height, child: this);
  }
}

extension TextWithStyles on String {
  Text normalText({TextStyle? style}) {
    TextStyle fontFamily = style ?? GoogleFonts.familjenGrotesk();
    return this.centerText(
      fontFamily.copyWith(
        fontSize: 14.rfs,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF808080),
        letterSpacing: -0.5.rfs,
      ),
    );
  }

  Text mediumHeadingText({TextStyle? style}) {
    TextStyle fontFamily = style ?? GoogleFonts.familjenGrotesk();
    return this.centerText(
      fontFamily.copyWith(
        fontSize: 28.rfs,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF000000),
        letterSpacing: -1.7.rfs,
      ),
    );
  }
}

extension TextToStyles on Text {
  Text fontWeight(FontWeight weight) {
    return Text(data ?? '', style: style?.copyWith(fontWeight: weight));
  }

  Text fontSize(double size) {
    return Text(data ?? '', style: style?.copyWith(fontSize: size));
  }

  Text color(Color color) {
    return Text(data ?? '', style: style?.copyWith(color: color));
  }
}

extension SvgPictureAssetExt on String {
  SvgPicture svgAsset({
    Color? color,
    BoxFit fit = BoxFit.contain,
    double? height,
    double? width,
    Alignment alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
  }) {
    return SvgPicture.asset(
      this,
      colorFilter: color != null
          ? ColorFilter.mode(color, BlendMode.srcIn)
          : null,
      fit: fit,
      height: height,
      width: width,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
    );
  }
}

// extension SvgGenExt on String {
//   SvgPicture? svgAsset() {
//     return SvgGenImage(this).svg();
//   }
// }

/// ----------------------
/// 1. Spacing & Layout
/// ----------------------
extension SpacingExt on num {
  /// Height spacing
  Widget get height => SizedBox(height: toDouble());

  /// Width spacing
  Widget get width => SizedBox(width: toDouble());

  /// Gap (requires `gap` package)
  Widget get gap => Gap(toDouble());
}

/// ----------------------
/// Strings → Widgets
/// ----------------------
extension StringWidgetExt on String {
  /// Convert string to Text widget
  Text get text => Text(this);

  /// Convert string to ElevatedButton
  Widget button({VoidCallback? onPressed}) =>
      ElevatedButton(onPressed: onPressed, child: Text(this));

  /// Convert Text align to center
  Text centerText([TextStyle? style]) =>
      Text(this, textAlign: TextAlign.center, style: style);
}

extension StringPaddingExt on String {
  /// Add padding to string
  Padding paddingAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: Text(this));

  Padding paddingSymmetric({double vertical = 0, double horizontal = 0}) =>
      Padding(
        padding: EdgeInsets.symmetric(
          vertical: vertical,
          horizontal: horizontal,
        ),
        child: Text(this),
      );

  Padding paddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) => Padding(
    padding: EdgeInsets.only(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    ),
    child: Text(this),
  );
}

/// ----------------------
/// Colors
/// ----------------------
extension ColorExt on String {
  /// Convert hex string like "#42A5F5" to Color
  Color get hexColor {
    final hex = replaceFirst('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }
}

extension IntColorExt on int {
  /// Convert int like 0xFF42A5F5 to Color
  Color get toColor => Color(this);
}

/// ----------------------
/// 5. Context Helpers
/// ----------------------
extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this); // use case: theme.textTheme
  TextTheme get textTheme => Theme.of(this).textTheme;
  // use case:
  //
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}

/// ----------------------
/// 6. Navigation
/// ----------------------
extension NavExt on BuildContext {
  Future<T?> go<T extends Object?>(String route, {Object? arguments}) =>
      Navigator.pushNamed(this, route, arguments: arguments);

  void pop<T extends Object?>([T? result]) => Navigator.pop(this, result);
}

/// ----------------------
/// 7. DateTime & Duration
/// ----------------------
extension DurationExt on int {
  Duration get seconds => Duration(seconds: this);
  Duration get minutes => Duration(minutes: this);
  Duration get hours => Duration(hours: this);
  Duration get days => Duration(days: this);
}

extension DateTimeExt on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }
}

/// ----------------------
/// 8. String Validation
/// ----------------------
extension StringValidationExt on String {
  bool get isEmail => RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(this);

  bool get isNumeric => double.tryParse(this) != null;
}

/// ----------------------
/// 9. Widget visibility
/// ----------------------
extension WidgetVisibilityExt on Widget {
  Widget visible(bool condition) => condition ? this : const SizedBox.shrink();
}

// import 'package:cresent_charge_user_app/gen/assets.gen.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

// /=--------- Route Base Path Extension --------=/
extension RouteBasePathExt on String {
  String get addBasePath {
    return RoutePath.basePath + this;
  }
}

// /=--------- API Base URL Extension --------=/
// extension ApiBasePathExt on String {
//   String get addBaseUrl {
//     return ApiUrl.baseUrl + this;
//   }
// }

// /=--------- Empty Gap from int --------=/
extension HeightWidthExt on int {
  Widget get heightWidth {
    return Gap(toDouble());
  }
}

// /=--------- Empty Gap from double --------=/
extension HeightWidthDoubleExt on double {
  Widget get heightWidth {
    return Gap(this);
  }
}

// /=--------- Widget -> Widget --------=/
extension WidgetOnWidgetExt on Widget {
  // center
  Widget get center => Center(child: this);

  // aspect ratio
  Widget aspectRatio(double width, double height) {
    return AspectRatio(aspectRatio: width / height, child: this);
  }

  // scaffold safe area
  Widget scaffold() {
    return Scaffold(body: this);
  }

  // scaffold safe area
  Widget scaffoldSafeArea() {
    return Scaffold(body: SafeArea(child: this));
  }

  // paddingXY
  Widget paddingXY({double? X, double? Y}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: X ?? 0, vertical: Y ?? 0),
      child: this,
    );
  }

  // paddingX
  Widget paddingX(double X) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: X),
      child: this,
    );
  }

  // paddingY
  Widget paddingY(double Y) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Y),
      child: this,
    );
  }

  // paddingT
  Widget paddingT(double T) {
    return Padding(
      padding: EdgeInsets.only(top: T),
      child: this,
    );
  }

  // paddingB
  Widget paddingB(double B) {
    return Padding(
      padding: EdgeInsets.only(bottom: B),
      child: this,
    );
  }

  // paddingL
  Widget paddingL(double L) {
    return Padding(
      padding: EdgeInsets.only(left: L),
      child: this,
    );
  }

  // paddingR
  Widget paddingR(double R) {
    return Padding(
      padding: EdgeInsets.only(right: R),
      child: this,
    );
  }
}

// ====================== Scaffold ======================
extension ListOfWidgetExt on List<Widget> {
  Widget scaffoldSafeAreaColumn({double? horizontalPadding}) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 0),
          child: Column(children: this),
        ),
      ),
    );
  }
}

/// ----------------------
/// Text -> Styles
/// ----------------------
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

  Text fontFamily(String? fontFamily) {
    return Text(data ?? '', style: style?.copyWith(fontFamily: fontFamily));
  }
}

/// ----------------------
/// Spacing & Layout
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
  Text text([TextStyle? style]) => Text(this, style: style);

  /// Convert Text align to center
  Text centerText([TextStyle? style]) =>
      Text(this, textAlign: TextAlign.center, style: style);
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
/// Context Helpers
/// ----------------------
extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this); // use case: theme.textTheme
  TextTheme get textTheme => Theme.of(this).textTheme;
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}

/// ----------------------
/// Navigation
/// ----------------------
extension NavExt on BuildContext {
  Future<T?> go<T extends Object?>(String route, {Object? arguments}) =>
      Navigator.pushNamed(this, route, arguments: arguments);

  void pop<T extends Object?>([T? result]) => Navigator.pop(this, result);
}

/// ----------------------
/// DateTime & Duration
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
/// String Validation
/// ----------------------
extension StringValidationExt on String {
  bool get isEmail => RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(this);

  bool get isNumeric => double.tryParse(this) != null;
}

// <== ! ==> Gesture Detectors <== ! ==>
extension GestureDetectors on Widget {
  Widget onTap(VoidCallback onTap) {
    return GestureDetector(onTap: onTap, child: this);
  }

  Widget onDoubleTap(VoidCallback onDoubleTap) {
    return GestureDetector(onDoubleTap: onDoubleTap, child: this);
  }

  Widget onLongPress(VoidCallback onLongPress) {
    return GestureDetector(onLongPress: onLongPress, child: this);
  }
}

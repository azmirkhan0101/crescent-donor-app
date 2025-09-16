// import 'package:cresent_charge_user_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:cresent_charge_user_app/core/routes/route_path.dart';

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

// /=--------- Widget on Widget --------=/
extension WidgetOnWidgetExt on Widget {
  // center
  Widget get center => Center(child: this);

  // aspect ratio
  Widget aspectRatio(double width, double height) {
    return AspectRatio(aspectRatio: width / height, child: this);
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
  Text get text => Text(this);

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

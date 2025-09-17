import 'package:flutter/material.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';

TextStyle style = const TextStyle(color: AppColors.black);

const lightThemeFont = "Inter Display", darkThemeFont = "Inter Display";

final lightTheme = ThemeData(
  primaryColor: AppColors.primaryColor,
  scaffoldBackgroundColor: Colors.white,
  brightness: Brightness.light,
  useMaterial3: true,
  fontFamily: lightThemeFont,
  // splashColor: Colors.transparent,
  // inputDecorationTheme: inputDecorationTheme,
  // drawerTheme: const DrawerThemeData(backgroundColor: AppColors.white),
  // textTheme: TextTheme(
  //   bodySmall: const TextStyle(color: AppColors.black),
  //   bodyMedium: GoogleFonts.inter(color: AppColors.black, fontSize: 18),
  //   bodyLarge: const TextStyle(color: AppColors.black),
  //   labelSmall: const TextStyle(color: AppColors.black),
  //   labelMedium: const TextStyle(color: AppColors.black),
  //   labelLarge: const TextStyle(color: AppColors.black),
  //   displaySmall: const TextStyle(color: AppColors.black),
  //   displayMedium: const TextStyle(color: AppColors.black),
  //   displayLarge: const TextStyle(color: AppColors.black),
  // ),
  // switchTheme: SwitchThemeData(
  //   thumbColor:
  //       WidgetStateProperty.resolveWith<Color>((states) => lightThemeColor),
  // ),
  // appBarTheme: appBarTheme,
  // bottomNavigationBarTheme: bottomNavigationBarTheme,
);

////=================== Input Decoration =======================

final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
  // border: OutlineInputBorder(
  //   borderRadius: BorderRadius.circular(8),
  //   borderSide: const BorderSide(color: AppColors.grayColor, width: 1),
  //   gapPadding: 0,
  // ),
  // focusedBorder: OutlineInputBorder(
  //   borderRadius: BorderRadius.circular(8),
  //   borderSide: const BorderSide(color: AppColors.primaryColor, width: 1),
  //   gapPadding: 0,
  // ),
  // enabledBorder: OutlineInputBorder(
  //   borderRadius: BorderRadius.circular(8),
  //   borderSide: const BorderSide(color: AppColors.grayColor, width: 1),
  //   gapPadding: 0,
  // ),
  // fillColor: AppColors.grayColor,
  // contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
  // hintStyle: const TextStyle(
  //   color: AppColors.black,
  //   fontWeight: FontWeight.w300,
  // ),
);

//=========================== App Bar =============================
final AppBarTheme appBarTheme = AppBarTheme(
  // //color:CustomColor.kPrimaryColorx,
  // elevation: 0,
  // centerTitle: true,
  // iconTheme: const IconThemeData(color: AppColors.black),
  // backgroundColor: AppColors.white,
  // scrolledUnderElevation: 0,
  // titleTextStyle: interMedium.copyWith(fontSize: 16.sp, color: black),
  // actionsIconTheme: const IconThemeData(color: AppColors.black),
  // systemOverlayStyle: const SystemUiOverlayStyle(
  //   // Status bar color
  //   statusBarColor: AppColors.white,
  //   // Status bar brightness (optional)
  //   statusBarIconBrightness: Brightness.light, // For Android (dark icons)
  //   statusBarBrightness: Brightness.light, // For iOS (dark icons)
  // ),
);

///========================= Bottom NavigationBar ==============================
// const BottomNavigationBarThemeData bottomNavigationBarTheme =
//     BottomNavigationBarThemeData(
//       backgroundColor: AppColors.white,
//       elevation: 1,
//       type: BottomNavigationBarType.fixed,
//       selectedItemColor: AppColors.primaryColor,
//       showUnselectedLabels: true,
//       selectedIconTheme: IconThemeData(size: 28),
//       unselectedItemColor: Colors.grey,
//       selectedLabelStyle: TextStyle(color: AppColors.primaryColor),
//     );

// ===================== Common colors =========================
const Color lightThemeColor = Colors.white,
    white = Colors.white,
    black = Colors.black,
    darkThemeColor = AppColors.primaryColor;

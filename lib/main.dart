import 'package:cresent_charge_user_app/core/routes/app_router.dart';
import 'package:cresent_charge_user_app/core/theme/theme.dart';
import 'package:cresent_charge_user_app/dependency_injection/getx_injection.dart';
import 'package:cresent_charge_user_app/global/language/controller/language_controller.dart';
import 'package:cresent_charge_user_app/service/app_storage_service.dart';
import 'package:cresent_charge_user_app/service/socket_service.dart';
import 'package:cresent_charge_user_app/utils/system_utils/system_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemUtil.setStatusBarColor(color: Colors.transparent);

  try {
    await AppStorageService.init();
    debugPrint('Storage service initialized successfully');
  } catch (e) {
    debugPrint('Failed to initialize storage service: $e');
    // Handle initialization error appropriately
  }

  initGetx();
  // initDependencies();

  SocketApi.init();

  LanguageController languageController = Get.put(LanguageController());
  languageController.getLanguageType();

  // Initialize theme controller
  Get.put(ThemeController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      key: Get.key,
      builder: (context, child) => GetBuilder<LanguageController>(
        builder: (controller) {
          return GetMaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Crescent Charge',
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: ThemeMode
                .system, // Automatically switch based on system preference
            routeInformationParser: AppRouter.router.routeInformationParser,
            routerDelegate: AppRouter.router.routerDelegate,
            routeInformationProvider: AppRouter.router.routeInformationProvider,
            //locale: const Locale("ar", "SA"),
            fallbackLocale: const Locale("en", "US"),
            translations: Language(),
          );
        },
      ),
    );
  }
}

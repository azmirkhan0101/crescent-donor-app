import 'package:cresent_charge_user_app/core/dependency_injection/getx_injection.dart';
import 'package:cresent_charge_user_app/core/go-router/app_router.dart';
import 'package:cresent_charge_user_app/core/theme/theme.dart';
import 'package:cresent_charge_user_app/global/language/controller/language_controller.dart';
import 'package:cresent_charge_user_app/service/app_storage_service.dart';
import 'package:cresent_charge_user_app/service/socket_service.dart';
import 'package:cresent_charge_user_app/utils/system_utils/system_utils.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemUtil.setStatusBarColor(color: Colors.transparent);

  // Initialize Stripe
  // Set publishable key
  Stripe.publishableKey =
      'pk_test_51SRlzVGWHt6mKfvJc2YG3Bt8NX85IpFnPNbcZcUMTkfQLjQu6RX8f3WcPYHpL6MPEke0mKO5EbIkXIBvfsVoWj5G0046sAl8FY';
  // 'pk_test_51SWjbnK1ijE5rN5Ysh5jg0XXhNxmfZMDQRPPsuShfensr6FsjXpakDqNdUJHv8Gc3qseUO4oUUDEsv5Mpe3Ksiw400u2W4nMLA';

  // Initialize Stripe instance (required for Android)
  await Stripe.instance.applySettings();

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

  runApp(DevicePreview(enabled: false, builder: (context) => const MyApp()));
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
                .light, // Automatically switch based on system preference
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

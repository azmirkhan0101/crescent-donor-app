import 'package:cresent_charge_user_app/core/dependency_injection/getx_injection.dart';
import 'package:cresent_charge_user_app/core/go-router/app_router.dart';
import 'package:cresent_charge_user_app/core/theme/theme.dart';
import 'package:cresent_charge_user_app/firebase_options.dart';
import 'package:cresent_charge_user_app/global/language/controller/language_controller.dart';
import 'package:cresent_charge_user_app/service/api_service.dart';
import 'package:cresent_charge_user_app/service/app_storage_service.dart';
import 'package:cresent_charge_user_app/service/firebase_notification_service.dart';
import 'package:cresent_charge_user_app/utils/system_utils/system_utils.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemUtil.setStatusBarColor(color: Colors.transparent);

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize Stripe
  try {
    Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY']!;

    // Initialize Stripe instance (required for Android)
    await Stripe.instance.applySettings();
  } catch (_) {}

  try {
    await AppStorageService.init();
  }catch(_){}

  initGetx();
  await Get.putAsync(() {
    return ApiService().init();
  });
  LanguageController languageController = Get.put(LanguageController());
  languageController.getLanguageType();

  // Initialize theme controller
  Get.put(ThemeController());

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize Firebase Notification Service
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await FirebaseNotificationService.instance.initialize();


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
                .light,
            routeInformationParser: AppRouter.router.routeInformationParser,
            routerDelegate: AppRouter.router.routerDelegate,
            routeInformationProvider: AppRouter.router.routeInformationProvider,
            fallbackLocale: const Locale("en", "US"),
            translations: Language()
          );
        },
      ),
    );
  }
}

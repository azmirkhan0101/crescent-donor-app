import 'package:cresent_charge_user_app/core/routes/routes.dart';
import 'package:cresent_charge_user_app/core/theme/light_theme.dart';
import 'package:cresent_charge_user_app/dependency_injection/getx_injection.dart';
import 'package:cresent_charge_user_app/global/language/controller/language_controller.dart';
import 'package:cresent_charge_user_app/service/socket_service.dart';
import 'package:cresent_charge_user_app/utils/system_utils/system_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemUtil.setStatusBarColor(color: Colors.transparent);

  initGetx();
  // initDependencies();

  SocketApi.init();

  LanguageController languageController = Get.put(LanguageController());
  languageController.getLanguageType();

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
            theme: lightTheme,
            routeInformationParser: AppRouter.route.routeInformationParser,
            routerDelegate: AppRouter.route.routerDelegate,
            routeInformationProvider: AppRouter.route.routeInformationProvider,
            //locale: const Locale("ar", "SA"),
            fallbackLocale: const Locale("en", "US"),
            translations: Language(),
          );
        },
      ),
    );
  }
}

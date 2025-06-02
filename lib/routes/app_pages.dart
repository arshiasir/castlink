import 'package:get/get.dart';
import 'package:castlink/routes/app_routes.dart';
import 'package:castlink/app/modules/splash/splash_screen.dart';
import 'package:castlink/app/modules/home/home_page.dart';
import 'package:castlink/app/modules/splash/splash_controller.dart';
import 'package:castlink/app/modules/home/home_controller.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => const SplashScreen(),
      binding: BindingsBuilder(() {
        Get.put(SplashController());
      }),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomePage(),
      binding: BindingsBuilder(() {
        Get.put(HomeController());
      }),
    ),
  ];
} 
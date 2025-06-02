import 'package:get/get.dart';
import 'package:castlink/app/modules/splash/splash_screen.dart';
import 'package:castlink/app/modules/home/home_page.dart';
import 'package:castlink/app/modules/video_player/video_player_page.dart';
import 'package:castlink/app/modules/splash/splash_controller.dart';
import 'package:castlink/app/modules/home/home_controller.dart';
import 'package:castlink/app/modules/video_player/video_player_controller.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashScreen(),
      binding: BindingsBuilder(() {
        Get.put(SplashController());
      }),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
      binding: BindingsBuilder(() {
        Get.put(HomeController());
      }),
    ),
    GetPage(
      name: Routes.VIDEO_PLAYER,
      page: () => const VideoPlayerPage(),
      binding: BindingsBuilder(() {
        Get.put(CustomVideoPlayerController());
      }),
    ),
  ];
} 
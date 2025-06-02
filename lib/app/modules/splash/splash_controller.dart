import 'dart:async';
import 'package:get/get.dart';
import 'package:castlink/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Timer(const Duration(seconds: 2), () {
      Get.offAllNamed(AppRoutes.HOME);
    });
  }
} 
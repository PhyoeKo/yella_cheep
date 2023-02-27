import 'package:explore_places/get_x/features/splash_screen/controller/splash_screen_controller.dart';
import 'package:get/get.dart';

class SplashScreenBinding extends  Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashScreenController());
  }
}
import 'package:explore_places/get_x/features/main_home/controller/main_home_controller.dart';
import 'package:get/get.dart';

class MainHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainHomeController());

  }
}

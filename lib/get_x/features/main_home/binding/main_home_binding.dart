import 'package:get/get.dart';
import 'package:yella_merchant/features/main_home/controller/main_home_controller.dart';
class MainHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainHomeController());

  }
}

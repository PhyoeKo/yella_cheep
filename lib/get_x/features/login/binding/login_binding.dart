import 'package:get/get.dart';
import 'package:yella_merchant/features/login/controller/login_controller.dart';


class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}

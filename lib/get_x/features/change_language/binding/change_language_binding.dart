import 'package:get/get.dart';
import 'package:yella_merchant/features/change_language/controller/change_language_controller.dart';

class ChangeLanguageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangeLanguageController());
  }
}

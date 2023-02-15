import 'package:get/get.dart';
import 'package:yella_merchant/features/sample_feature/controller/sample_controller.dart';

import '../mapper/sample_mapper.dart';

class SampleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SampleController());
  }
}

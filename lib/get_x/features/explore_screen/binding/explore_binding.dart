

import 'package:explore_places/get_x/features/explore_screen/controller/explore_controller.dart';
import 'package:get/get.dart';

class ExploreBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ExploreController());
  }

}
import 'package:explore_places/get_x/features/search/controller/search_controller.dart';
import 'package:get/get.dart';

class SearchBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchController());
  }
}

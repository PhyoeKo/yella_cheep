import 'package:explore_places/get_x/core/binding/view_controller_binding.dart';
import 'package:explore_places/get_x/data_sources/network/favourite/favourite_repository.dart';
import 'package:explore_places/get_x/features/favourite/controller/favourite_controller.dart';
import 'package:get/get.dart';

class FavouriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavouriteController(findInject(FavouriteRepository)));
  }
}

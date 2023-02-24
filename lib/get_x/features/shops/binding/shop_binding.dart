import 'package:explore_places/get_x/core/binding/view_controller_binding.dart';
import 'package:explore_places/get_x/data_sources/network/shop/shop_repository.dart';
import 'package:explore_places/get_x/features/shops/controller/shop_controller.dart';
import 'package:explore_places/get_x/features/shops/controller/shop_detail_controller.dart';
import 'package:get/get.dart';

class ShopBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShopController(findInject(ShopRepository)));
    Get.lazyPut(() => ShopDetailController());
  }
}

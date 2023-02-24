import 'package:explore_places/get_x/core/base/base_controller.dart';
import 'package:explore_places/get_x/core/binding/view_controller_binding.dart';
import 'package:explore_places/get_x/data_sources/network/home/home_repository.dart';
import 'package:explore_places/get_x/data_sources/network/shop/shop_repository.dart';
import 'package:explore_places/get_x/features/home/controller/home_controller.dart';
import 'package:explore_places/get_x/features/shops/controller/shop_controller.dart';
import 'package:get/get.dart';

class ExploreController extends BaseController {
  final HomeController homeController =
      HomeController(findInject(HomeRepository));
  final ShopController shopController =
      ShopController(findInject(ShopRepository));


  RxInt selectedStateId = 0.obs;
  @override
  void onInit() {
    super.onInit();
    homeController.getStateList();
  }


}

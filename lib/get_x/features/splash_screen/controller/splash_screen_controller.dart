import 'package:explore_places/get_x/constant/routing/app_route.dart';
import 'package:explore_places/get_x/core/base/base_controller.dart';
import 'package:explore_places/get_x/core/binding/view_controller_binding.dart';
import 'package:explore_places/get_x/data_sources/network/home/home_repository.dart';
import 'package:explore_places/get_x/features/home/controller/home_controller.dart';
import 'package:get/get.dart';

class SplashScreenController extends BaseController {
  final HomeController homeController =
      HomeController(findInject(HomeRepository));

  @override
  void onInit()  {
    super.onInit();
    Future.delayed(Duration(seconds: 3), ()=> Get.offAllNamed(Routes.mainHomeScreen));
  }
}

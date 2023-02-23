import 'package:explore_places/get_x/core/base/base_controller.dart';
import 'package:explore_places/get_x/core/binding/view_controller_binding.dart';
import 'package:explore_places/get_x/data_sources/network/home/home_repository.dart';
import 'package:explore_places/get_x/features/home/controller/home_controller.dart';

class ExploreController extends BaseController {

  final HomeController homeController =
      HomeController(findInject(HomeRepository));


}

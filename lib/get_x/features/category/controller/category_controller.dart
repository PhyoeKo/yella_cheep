import 'package:explore_places/get_x/core/base/base_controller.dart';
import 'package:explore_places/get_x/core/binding/view_controller_binding.dart';
import 'package:explore_places/get_x/data_models/view_object/setup_vo.dart';
import 'package:explore_places/get_x/data_sources/network/home/home_repository.dart';
import 'package:explore_places/get_x/features/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends BaseController {
  late TabController tabController;
  // final HomeController homeController =
  //     HomeController(findInject(HomeRepository));
  List<SetUpVo>  categoryList= [];
  @override
  void onInit() {
    super.onInit();
   categoryList = Get.arguments;
    print("Caategro ${ categoryList.length}");

    tabController = TabController(
      vsync: this,
      length: categoryList.length,
    );
    tabController.index =2;
  }
}

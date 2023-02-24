import 'package:explore_places/get_x/core/base/base_controller.dart';
import 'package:explore_places/get_x/features/explore_screen/screen/explore_screen.dart';
import 'package:explore_places/get_x/features/favourite/screen/favourite_list_screen.dart';
import 'package:explore_places/get_x/features/order_history/screen/order_history_screen.dart';
import 'package:explore_places/get_x/features/profile/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/screen/home_screen.dart';


class MainHomeController extends BaseController {
  Rx<int> currentPageIndex = 0.obs;

  final List<Widget> widgetPages = [
    HomeScreen(),
    ExploreScreen(),
    FavouriteListScreen(),
    ProfileScreen(),
  ];

  @override
  void onInit() {
    super.onInit();
  }

  void changeCurrentPageIndex(int index) {
    currentPageIndex.value = index;
  }
}

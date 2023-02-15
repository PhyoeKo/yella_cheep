import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yella_merchant/core/base/base_controller.dart';
import 'package:yella_merchant/features/home/screen/home_screen.dart';
import 'package:yella_merchant/features/order_history/screen/order_history_screen.dart';
import 'package:yella_merchant/features/profile/screen/profile_screen.dart';

class MainHomeController extends BaseController {
  Rx<int> currentPageIndex = 0.obs;

  final List<Widget> widgetPages = [
    HomeScreen(),
    OrderHistoryScreen(),
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

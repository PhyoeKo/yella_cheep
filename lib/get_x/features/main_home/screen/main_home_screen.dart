import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/constant/resources/app_dimens.dart';
import 'package:explore_places/get_x/core/base/base_view.dart';
import 'package:explore_places/get_x/features/main_home/controller/main_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MainHomeScreen extends BaseView<MainHomeController> {
  MainHomeScreen({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget? bottomNavigationBar() {
    return Obx(
      () => BottomNavigationBar(
        currentIndex: controller.currentPageIndex.value,
        onTap: (index) => controller.changeCurrentPageIndex(index),
        elevation: 4,
        selectedLabelStyle: const TextStyle(
          fontSize: AppDimens.TEXT_SMALL,
          color: AppColors.blackColor,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: AppDimens.TEXT_SMALL,
          color: AppColors.shadeGrayColor,
          fontWeight: FontWeight.w400,
        ),
        selectedItemColor: AppColors.darkBlueColor,
        selectedIconTheme: const IconThemeData(color: AppColors.darkBlueColor),
        unselectedItemColor: AppColors.shadeGrayColor,
        showUnselectedLabels: true,
        backgroundColor: AppColors.whiteColor,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "My Cars",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            activeIcon: Icon(Icons.history),
            label: "Order History",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            activeIcon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  @override
  Widget body(BuildContext context) {
    return Obx(() => WillPopScope(
        child: controller.widgetPages.elementAt(
          controller.currentPageIndex.value,
        ),
        onWillPop: () async {
          if (controller.currentPageIndex.value != 0) {
            controller.currentPageIndex.value = 0;
            return false;
          } else {
            return true;
          }
        }));
  }
}

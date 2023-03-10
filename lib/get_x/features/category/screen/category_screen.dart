import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/core/utils/custom_tab_indicator.dart';
import 'package:explore_places/get_x/core/utils/sliver_app_delegete.dart';
import 'package:explore_places/get_x/features/category/controller/category_controller.dart';
import 'package:explore_places/get_x/widget/default_app_bar_widget.dart';
import 'package:explore_places/get_x/widget/shop/shop_item_widget.dart';
import 'package:explore_places/get_x/widget/view_handling/smart_refresher_parent_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/preferred_size.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../core/base/base_view.dart';

class CategoryScreen extends BaseView<CategoryController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return DefaultAppBar(
      title: 'explore'.tr,
    );
  }

  @override
  Widget body(BuildContext context) {
    return DefaultTabController(
      length: controller.categoryList.length,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverPersistentHeader(
              delegate: SliverAppBarDelegate(
                  TabBar(
                    controller: controller.tabController,
                    isScrollable: true,
                    labelColor: AppColors.blackColor,
                    indicator: const CustomTabIndicator(),
                    tabs: controller.categoryList
                        .map(
                          (item) => Tab(height: 52, text: item.name),
                        )
                        .toList(),
                  ),
                  height: 48),
              pinned: true,
            ),
          ];
        },
        body: TabBarView(
          controller: controller.tabController,
          children: controller.categoryList
              .map((item) => ShopListWidget(
                    controller: controller,
                    refreshController: controller.refreshController,
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class ShopListWidget extends StatelessWidget {
  final CategoryController controller;
  final RefreshController refreshController;

  const ShopListWidget(
      {Key? key, required this.controller, required this.refreshController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: const EdgeInsets.all(8.0),
          child: SmartRefresherParentView(
            refreshController: refreshController,
            enablePullUp: false,
            onRefresh: () =>
                controller.getShopList(refreshController: refreshController),
            onLoading: () =>
                controller.getShopList(refreshController: refreshController),
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: ShopItemWidget(
                                shopItem: controller.shopList[index]),
                          ));
                    },
                    childCount: controller.shopList.length,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

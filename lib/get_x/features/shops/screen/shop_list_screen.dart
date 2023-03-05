import 'package:explore_places/get_x/constant/resources/app_string.dart';
import 'package:explore_places/get_x/core/base/base_view.dart';
import 'package:explore_places/get_x/features/shops/controller/shop_controller.dart';
import 'package:explore_places/get_x/widget/default_app_bar_widget.dart';
import 'package:explore_places/get_x/widget/shop/shop_item_widget.dart';
import 'package:explore_places/get_x/widget/view_handling/smart_refresher_parent_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ShopListScreen extends BaseView<ShopController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return DefaultAppBar(title: AppString.shop.tr);
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget body(BuildContext context) {
    return Obx(() => Padding(
          padding: const EdgeInsets.all(8.0),
          child: SmartRefresherParentView(
            refreshController: _refreshController,
            enablePullUp: true,
            onRefresh: () => controller.resetNearNearByShopList(
                refreshController: _refreshController),
            onLoading: () => controller.getNearByShop(refreshController: _refreshController),
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
                                shopItem: controller.nearByShopList[index]),
                          ));
                    },
                    childCount: controller.nearByShopList.length,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

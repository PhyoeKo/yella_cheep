import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/constant/resources/app_dimens.dart';
import 'package:explore_places/get_x/constant/resources/app_string.dart';
import 'package:explore_places/get_x/core/base/base_view.dart';
import 'package:explore_places/get_x/core/utils/sliver_app_delegete.dart';
import 'package:explore_places/get_x/features/search/controller/search_controller.dart';
import 'package:explore_places/get_x/widget/app_bar/cupertino_sliver_app_bar.dart';
import 'package:explore_places/get_x/widget/custom_search_field.dart';
import 'package:explore_places/get_x/widget/default_app_bar_widget.dart';
import 'package:explore_places/get_x/widget/shop/shop_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends BaseView<SearchController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return Obx(() => NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              CupertinoSliverAppBar(
                title: AppString.searchHere.tr,
              ),
              SliverPersistentHeader(
                delegate: SliverAppBarDelegate(
                  Container(
                  //  padding: const EdgeInsets.symmetric(horizontal: 8),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child:CustomSearchField(
                      onClear: () => print(''),
                      isClearEnable: true,
                      onChanged: (query) {
                        // if (query == "") provider.resetAndGetProductList();
                        // provider.setIsClearEnable();
                      },
                      hint: AppString.enter_shop_name.tr,
                      controller: controller.textEditingController,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (query) {
                        controller.getShopList(name: query);
                        // provider.resetAndGetProductList();
                      },
                    ),
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: ListView.builder(
              itemCount: controller.shopList.length,
              itemBuilder: (_, index) {
                return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 12),
                      child:
                          ShopItemWidget(shopItem: controller.shopList[index]),
                    ));
              }),
          // body: SliverList(
          //   delegate: SliverChildBuilderDelegate(
          //     (BuildContext context, int index) {
          //       return SizedBox(
          //           height: MediaQuery.of(context).size.height * 0.4,
          //           child: Padding(
          //             padding: const EdgeInsets.symmetric(
          //                 vertical: 12.0, horizontal: 12),
          //             child:
          //                 ShopItemWidget(shopItem: controller.shopList[index]),
          //           ));
          //     },
          //     childCount: controller.shopList.length,
          //   ),
          // ),
        ));
  }
}

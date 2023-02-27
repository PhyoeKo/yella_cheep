import 'package:explore_places/get_x/constant/resources/app_dimens.dart';
import 'package:explore_places/get_x/core/base/base_view.dart';
import 'package:explore_places/get_x/features/search/controller/search_controller.dart';
import 'package:explore_places/get_x/widget/custom_search_field.dart';
import 'package:explore_places/get_x/widget/default_app_bar_widget.dart';
import 'package:explore_places/get_x/widget/shop/shop_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends BaseView<SearchController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return DefaultAppBar(title: "Search");
  }

  @override
  Widget body(BuildContext context) {
    return Obx(() => CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.MARGIN_CARD_MEDIUM,
                vertical: AppDimens.MARGIN_MEDIUM),
            child: CustomSearchField(
              onClear: () => print(''),
              isClearEnable: true,
              onChanged: (query) {
                // if (query == "") provider.resetAndGetProductList();
                // provider.setIsClearEnable();
              },
              hint: "Enter shop name...",
              controller: controller.textEditingController,
              textInputAction: TextInputAction.search,
              onSubmitted: (query) {
                controller.getShopList(name: query);
                // provider.resetAndGetProductList();
              },
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 12),
                    child: ShopItemWidget(shopItem: controller.shopList[index]),
                  ));
            },
            childCount: controller.shopList.length,
          ),
        ),
      ],
    ));
  }
}

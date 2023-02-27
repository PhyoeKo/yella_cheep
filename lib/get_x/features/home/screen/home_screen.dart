import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:explore_places/get_x/constant/enum/shop_type_enum.dart';
import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/constant/resources/app_dimens.dart';
import 'package:explore_places/get_x/constant/routing/app_route.dart';
import 'package:explore_places/get_x/core/base/base_view.dart';
import 'package:explore_places/get_x/core/utils/app_utils.dart';
import 'package:explore_places/get_x/features/home/controller/home_controller.dart';
import 'package:explore_places/get_x/widget/cached_network_image_widget.dart';
import 'package:explore_places/get_x/widget/custom_chip_widget.dart';
import 'package:explore_places/get_x/widget/default_app_bar_widget.dart';
import 'package:explore_places/get_x/widget/shop/shop_item_widget.dart';
import 'package:explore_places/get_x/widget/text_view_widget.dart';
import 'package:explore_places/get_x/widget/view_handling/smart_refresher_parent_view.dart';
import 'package:explore_places/get_x/widget/widget_category_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends BaseView<HomeController> {
  HomeScreen({super.key});

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return  DefaultAppBar(title: "Home",trillingIcon: Icons.search,trillingIconOnClick: (){
      Get.toNamed(Routes.searchScreen);
    },);
  }

  @override
  Widget body(BuildContext context) {
    return Obx(() => SmartRefresherParentView(
          refreshController: _refreshController,
          enablePullUp: true,
          onRefresh: () => controller.resetAndGetCancelOrderList(
              refreshController: _refreshController),
          onLoading: () => controller.getBannerList(),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: controller.bannerList.isNotEmpty
                    ? Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: AppDimens.MARGIN_MEDIUM),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            height: MediaQuery.of(context).size.height * 0.2,
                            enlargeStrategy: CenterPageEnlargeStrategy.scale,
                          ),
                          items: controller.bannerList
                              .map(
                                (bannerItem) => GestureDetector(
                                  onTap: () => {
                                    if (bannerItem.bannerDetail!.isNotEmpty)
                                      {}
                                    else
                                      {
                                        AppUtils.showPreviewImageDialog(
                                            (bannerItem.image ?? ""))
                                      }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: AppDimens.MARGIN_SMALL),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          AppDimens.MARGIN_MEDIUM),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: CachedNetworkImageWidget(
                                          imageUrl: (bannerItem.image ?? ""),
                                          boxFit: BoxFit.cover,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      )
                    : Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        enabled: true,
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          margin: const EdgeInsets.all(AppDimens.MARGIN_MEDIUM),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                      ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: TextViewWidget(
                    "Category",
                    fontWeight: FontWeight.bold,
                    textSize: 16,
                    textColor: AppColors.primaryColor,
                  ),
                ),
              ),
              controller.categoryList.isNotEmpty
                  ? SliverToBoxAdapter(
                      child: Wrap(
                        alignment: WrapAlignment.spaceAround,
                        children: controller.categoryList
                            .map((category) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: AppDimens.MARGIN_SMALL,
                                      vertical: AppDimens.MARGIN_MEDIUM),
                                  child: GestureDetector(
                                    onTap: () {
                                      AppUtils.selectedID = category.id;
                                      Get.toNamed(
                                        Routes.shopList,
                                        arguments: ShopType.categoryBy,
                                      );
                                    },
                                    child: CategoryImageWidget(
                                      image: category.image ?? "",
                                      name: category.name ?? "",
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    )
                  : SliverToBoxAdapter(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        enabled: true,
                        child: Wrap(
                          alignment: WrapAlignment.spaceAround,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(
                                      AppDimens.MARGIN_MEDIUM),
                                  border: Border.all(
                                      color: AppColors.disabledButtonBgColor,
                                      width: 0.5)),
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(
                                      AppDimens.MARGIN_MEDIUM),
                                  border: Border.all(
                                      color: AppColors.disabledButtonBgColor,
                                      width: 0.5)),
                            )
                          ],
                        ),
                      ),
                    ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      TextViewWidget(
                        controller.shopController.nearByShopList.isNotEmpty
                            ? "Near by places"
                            : "",
                        fontWeight: FontWeight.bold,
                        textSize: 16,
                        textColor: AppColors.primaryColor,
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () => Get.toNamed(Routes.shopList,
                            arguments: ShopType.nearBy),
                        child: TextViewWidget(
                          controller.shopController.nearByShopList.isNotEmpty
                              ? "See all"
                              : "",
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: controller.shopController.nearByShopList.isNotEmpty
                    ? Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: AppDimens.MARGIN_MEDIUM),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: false,
                            enlargeCenterPage: true,
                            height: MediaQuery.of(context).size.height * 0.4,
                            enlargeStrategy: CenterPageEnlargeStrategy.scale,
                          ),
                          items: controller.shopController.nearByShopList
                              .map(
                                (shopItem) =>
                                    ShopItemWidget(shopItem: shopItem),
                              )
                              .toList(),
                        ),
                      )
                    : Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        enabled: true,
                        child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: AppDimens.MARGIN_MEDIUM,
                                horizontal: AppDimens.MARGIN_MEDIUM),
                            height: Get.height * 0.4,
                            width: Get.width * 0.8,
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(
                                  AppDimens.MARGIN_MEDIUM),
                            )),
                      ),
              ),
            ],
          ),
        ));
  }
}

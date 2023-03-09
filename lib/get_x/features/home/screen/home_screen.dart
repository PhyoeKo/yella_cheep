import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:explore_places/get_x/constant/enum/shop_type_enum.dart';
import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/constant/resources/app_dimens.dart';
import 'package:explore_places/get_x/constant/resources/app_string.dart';
import 'package:explore_places/get_x/constant/routing/app_route.dart';
import 'package:explore_places/get_x/core/base/base_view.dart';
import 'package:explore_places/get_x/core/utils/app_utils.dart';
import 'package:explore_places/get_x/core/utils/sliver_app_delegete.dart';
import 'package:explore_places/get_x/features/home/controller/home_controller.dart';
import 'package:explore_places/get_x/widget/cached_network_image_widget.dart';
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
    // return  DefaultAppBar(title: "Home",trillingIcon: Icons.search,trillingIconOnClick: (){
    //   Get.toNamed(Routes.searchScreen);
    // },);
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return SafeArea(
      child: Obx(() => CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverAppBarDelegate(Container(
                  width: Get.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(),
                      TextViewWidget(
                        AppString.home.tr,
                        textSize: 18,
                        textColor: AppColors.appBarColor,
                        fontWeight: FontWeight.bold,
                      ),
                      GestureDetector(
                          onTap: () => Get.toNamed(Routes.searchScreen),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.search),
                          )),
                    ],
                  ),
                  height: 75,
                )),
              ),
              SliverToBoxAdapter(
                child: controller.bannerList.isNotEmpty
                    ? CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 1,
                          aspectRatio: 1.8,
                          // autoPlayCurve: Curves.fastOutSlowIn,
                          // enlargeCenterPage: false,
                          // autoPlay: true,
                          //   height: MediaQuery.of(context).size.height * 0.25,
                          //enlargeStrategy: CenterPageEnlargeStrategy.height,
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
                                child: SizedBox(
                                  width: Get.width,
                                  child: CachedNetworkImageWidget(
                                    imageUrl: (bannerItem.image ?? ""),
                                    boxFit: BoxFit.cover,
                                    width: Get.width,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
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
                  padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                  child: TextViewWidget(
                    AppString.category.tr,
                    fontWeight: FontWeight.bold,
                    textSize: 18,
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
                                        Routes.categoryScreen,
                                        arguments: controller.categoryList,
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
                        controller.shopController.shopList.isNotEmpty
                            ? AppString.nearByPlace.tr
                            : "",
                        fontWeight: FontWeight.bold,
                        textSize: 18,
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () => Get.toNamed(Routes.shopList,
                            arguments: ShopType.nearBy),
                        child: TextViewWidget(
                          controller.shopController.shopList.isNotEmpty
                              ? AppString.see_all.tr
                              : "",
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: controller.shopController.shopList.isNotEmpty
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
                          items: controller.shopController.shopList
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
              SliverToBoxAdapter(
                child: controller.homeList.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          top: 8.0,
                        ),
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.homeList.length,
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextViewWidget(
                                    controller.homeList[index].name ?? "",
                                    fontWeight: FontWeight.bold,
                                    textSize: 18,
                                  ),
                                  SizedBox(
                                    height: AppDimens.MARGIN_MEDIUM_2,
                                  ),
                                  Flexible(
                                    child: SizedBox(
                                      height: Get.height * 0.35,
                                      width: Get.width,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        physics: ClampingScrollPhysics(),
                                        itemCount: controller
                                            .homeList[index].shop?.length,
                                        itemBuilder:
                                            (BuildContext context, int i) =>
                                                Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: HomeCategoryWidget(
                                              image: controller.homeList[index]
                                                      .shop?[i].image1 ??
                                                  "",
                                              name: controller.homeList[index]
                                                      .shop?[i].name ??
                                                  "",
                                              discount: controller
                                                      .homeList[index]
                                                      .shop?[i]
                                                      .discount ??
                                                  "",
                                              state: controller.homeList[index]
                                                      .shop?[i].state?.name ??
                                                  ""),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // CarouselSlider(
                                  //   options: CarouselOptions(
                                  //     autoPlay: true,
                                  //     enlargeCenterPage: true,
                                  //     viewportFraction: 1,
                                  //     aspectRatio: 1.8,
                                  //   ),
                                  //   items: controller.homeList[index].shop
                                  //       ?.map(
                                  //         (shopItem) => Column(
                                  //           crossAxisAlignment:
                                  //               CrossAxisAlignment.start,
                                  //           children: [
                                  //             CategoryImageWidget(
                                  //               image: shopItem.image1 ?? "",
                                  //               name: shopItem.name ?? "",
                                  //             )
                                  //           ],
                                  //         ),
                                  //       )
                                  //       .toList(),
                                  // )
                                  // controller.homeList[index].shop.map((e) => TextViewWidget(text)).toList();
                                ],
                              );
                            }),
                      )
                    : SizedBox(),
              )
            ],
          )),
    );
  }
}

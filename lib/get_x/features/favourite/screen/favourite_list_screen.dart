import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/constant/resources/app_string.dart';
import 'package:explore_places/get_x/constant/routing/app_route.dart';
import 'package:explore_places/get_x/core/base/base_view.dart';
import 'package:explore_places/get_x/core/services/dio_provider.dart';
import 'package:explore_places/get_x/features/favourite/controller/favourite_controller.dart';
import 'package:explore_places/get_x/widget/app_bar/cupertino_sliver_app_bar.dart';
import 'package:explore_places/get_x/widget/custom_chip_widget.dart';
import 'package:explore_places/get_x/widget/goLogin/go_login_widget.dart';
import 'package:explore_places/get_x/widget/view_handling/smart_refresher_parent_view.dart';
import 'package:explore_places/main_temp.dart';
import 'package:explore_places/utils/Common.dart';
import 'package:explore_places/utils/Extensions/Colors.dart';
import 'package:explore_places/utils/Extensions/Constants.dart';
import 'package:explore_places/utils/Extensions/Widget_extensions.dart';
import 'package:explore_places/utils/Extensions/decorations.dart';
import 'package:explore_places/utils/Extensions/int_extensions.dart';
import 'package:explore_places/utils/Extensions/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/preferred_size.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../utils/AppImages.dart';

class FavouriteListScreen extends BaseView<FavouriteController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget body(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            CupertinoSliverAppBar(
              title: AppString.favourite.tr,
            ),
          ];
        },
        body: Obx(() => controller.mainHomeController.isLogin.value
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: SmartRefresherParentView(
                  refreshController: _refreshController,
                  enablePullUp: true,
                  onRefresh: () => controller.resetNearNearByShopList(
                      refreshController: _refreshController),
                  onLoading: () => controller.getFavShopList(),
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return AnimationConfiguration.staggeredList(
                              duration: Duration(milliseconds: 800),
                              position: index,
                              child: SlideAnimation(
                                horizontalOffset: 50.0,
                                verticalOffset: 20.0,
                                child: FadeInAnimation(
                                    child: InkWell(
                                  onTap: () => Get.toNamed(Routes.shopDetail,
                                      arguments: controller
                                          .nearByShopList[index].shop),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    clipBehavior: Clip.none,
                                    children: [
                                      cachedImage(
                                        DioProvider.baseUrl +
                                            "${controller.nearByShopList[index].shop?.image1 ?? ""}",
                                        height: 200,
                                        width: Get.width * 0.9,
                                        fit: BoxFit.cover,
                                      ).cornerRadiusWithClipRRect(
                                          defaultRadius),
                                      Container(
                                        height: 200,
                                        width: Get.width * 0.75,
                                        decoration: BoxDecoration(
                                            borderRadius: radius(defaultRadius),
                                            border: Border.all(
                                                color: Colors.transparent),
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.black.withOpacity(0.1),
                                                  Colors.black.withOpacity(0.3),
                                                  Colors.black.withOpacity(0.5),
                                                  Colors.black.withOpacity(0.7),
                                                ])),
                                      ),
                                      Positioned(
                                        left: 10,
                                        right: 10,
                                        top: 10,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ratingWidget((controller
                                                    .nearByShopList[index]
                                                    .shop
                                                    ?.discount ??
                                                "")),
                                          ],
                                        ),
                                      ).visible(true),
                                      Positioned(
                                        right: 10,
                                        top: 10,
                                        child: CustomChipWidget(
                                            text: "${calculateDistanceKm(
                                          controller
                                              .homeController.currentLat.value,
                                          controller
                                              .homeController.currentLong.value,
                                          double.parse(controller
                                              .nearByShopList[index]
                                              .shop
                                              ?.latitude),
                                          double.parse(controller
                                              .nearByShopList[index]
                                              .shop
                                              ?.longitude),
                                        ).toStringAsFixed(2)} Km away"),
                                      ).visible(true),
                                      Positioned(
                                        left: 20,
                                        right: 10,
                                        bottom: 10,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                controller.nearByShopList[index]
                                                        .shop?.name ??
                                                    "",
                                                style: boldTextStyle(
                                                    color: AppColors.whiteColor,
                                                    size: 18),
                                                maxLines: 2),
                                            6.height,
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                            Icons
                                                                .location_on_outlined,
                                                            color: whiteColor,
                                                            size: 20),
                                                        4.width,
                                                        Text(
                                                          controller
                                                                  .nearByShopList[
                                                                      index]
                                                                  .shop
                                                                  ?.attractions ??
                                                              "Addres",
                                                          style:
                                                              secondaryTextStyle(
                                                                  color:
                                                                      whiteColor),
                                                          maxLines: 2,
                                                        ).expand(),
                                                      ],
                                                    ),
                                                    if (appStore
                                                            .currentPosition !=
                                                        null)
                                                      Row(
                                                        children: [
                                                          ImageIcon(
                                                              AssetImage(
                                                                  ic_distance),
                                                              color: whiteColor,
                                                              size: 20),
                                                          4.width,
                                                          Text(
                                                            '${calculateDistanceKm(appStore.currentPosition!.latitude, appStore.currentPosition!.longitude, 16.233, 96.2323).toStringAsFixed(2)} Km',
                                                            style: secondaryTextStyle(
                                                                color:
                                                                    whiteColor),
                                                          ),
                                                        ],
                                                      ).paddingTop(8),
                                                  ],
                                                ).expand(),
                                                8.width,
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )).paddingBottom(16),
                              ),
                            );
                          },
                          childCount: controller.nearByShopList.length,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: GoLoginWidget(
                    desc:
                        AppString.seeFavouriteDataAfterLogin.tr,
                    title: AppString.loginToViewYourFavourite.tr),
              )));
  }
}

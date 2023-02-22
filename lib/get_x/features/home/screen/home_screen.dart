import 'package:carousel_slider/carousel_slider.dart';
import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/constant/resources/app_dimens.dart';
import 'package:explore_places/get_x/constant/routing/app_route.dart';
import 'package:explore_places/get_x/core/base/base_view.dart';
import 'package:explore_places/get_x/core/utils/app_utils.dart';
import 'package:explore_places/get_x/features/home/controller/home_controller.dart';
import 'package:explore_places/get_x/widget/cached_network_image_widget.dart';
import 'package:explore_places/get_x/widget/default_app_bar_widget.dart';
import 'package:explore_places/get_x/widget/text_view_widget.dart';
import 'package:explore_places/get_x/widget/view_handling/smart_refresher_parent_view.dart';
import 'package:explore_places/get_x/widget/widget_category_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends BaseView<HomeController> {
  HomeScreen({super.key});

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return const DefaultAppBar(title: "Home");
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
                                      {
                                        // Navigator.pushNamed(context,
                                        //     BannerDetailScreen.routeName,
                                        //     arguments: {
                                        //       "type": bannerItem.type,
                                        //       "bannerDetail":
                                        //       bannerItem.detail,
                                        //       "subscribeStatus":
                                        //       bannerItem.subscribeStatus
                                        //     }),
                                      }
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
                    : const SizedBox(),
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
                                      // homePageProvider
                                      //     .setSelectedCategoryList(
                                      //     category.id??0);
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
                  : const SliverPadding(padding: EdgeInsets.zero),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextViewWidget(
                    "Near by places",
                    fontWeight: FontWeight.bold,
                    textSize: 16,
                    textColor: AppColors.primaryColor,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: controller.nearByShopList.isNotEmpty
                    ? Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: AppDimens.MARGIN_MEDIUM),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      height: MediaQuery.of(context).size.height * 0.4,
                      enlargeStrategy: CenterPageEnlargeStrategy.scale,
                    ),
                    items: controller.nearByShopList
                        .map(
                          (shopItem) => GestureDetector(
                        onTap: () => {

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
                                imageUrl: ( "/storage/shop/91676351357.jpeg"),
                                boxFit: BoxFit.cover,
                                width: MediaQuery.of(context)
                                    .size
                                    .width *
                                    0.4,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                        .toList(),
                  ),
                )
                    : const SizedBox(),
              ),

            ],
          ),
        ));
  }
}


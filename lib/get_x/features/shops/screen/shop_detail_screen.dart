import 'package:cached_network_image/cached_network_image.dart';
import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/constant/resources/app_dimens.dart';
import 'package:explore_places/get_x/constant/resources/app_string.dart';
import 'package:explore_places/get_x/core/base/base_view.dart';
import 'package:explore_places/get_x/core/utils/custom_tab_indicator.dart';
import 'package:explore_places/get_x/core/utils/sliver_app_delegete.dart';
import 'package:explore_places/get_x/features/shops/controller/shop_controller.dart';
import 'package:explore_places/get_x/features/shops/controller/shop_detail_controller.dart';
import 'package:explore_places/get_x/features/shops/screen/review_widget.dart';
import 'package:explore_places/get_x/features/shops/screen/shop_gallery_widget.dart';
import 'package:explore_places/get_x/widget/cached_network_image_widget.dart';
import 'package:explore_places/get_x/widget/custom_chip_widget.dart';
import 'package:explore_places/get_x/widget/default_app_bar_widget.dart';
import 'package:explore_places/get_x/widget/dialog/dialog_write_review.dart';
import 'package:explore_places/get_x/widget/text_view_widget.dart';
import 'package:explore_places/get_x/widget/widget_rounded_icon.dart';
import 'package:explore_places/utils/Extensions/Widget_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/preferred_size.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class ShopDetailScreen extends BaseView<ShopDetailController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  toolbarHeight: kToolbarHeight,
                  expandedHeight: Get.height * 0.4,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImageWidget(
                              boxFit: BoxFit.cover,
                              imageUrl: controller.shopItem?.image1,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                    Colors.black.withOpacity(0.1),
                                    Colors.black.withOpacity(0.1),
                                    Colors.black.withOpacity(0.3),
                                    Colors.black.withOpacity(0.9),
                                  ])),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 16,
                          left: 16,
                          right: 16,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  TextViewWidget(
                                    controller.shopItem?.name ?? "",
                                    textColor: AppColors.whiteColor,
                                    textSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  RatingBarIndicator(
                                    rating: controller.shopItem?.rating
                                            ?.toDouble() ??
                                        0,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: AppColors.primaryColor,
                                    ),
                                    itemCount: 5,
                                    itemSize: 14.0,
                                    direction: Axis.horizontal,
                                  ),
                                  TextViewWidget(
                                    "(${controller.shopItem?.state})",
                                    textColor: AppColors.whiteColor,
                                    textSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              controller.shopItem?.distance != null
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 6.0),
                                      child: CustomChipWidget(
                                          text:
                                              "${controller.shopItem?.distance} Km away"),
                                    )
                                  : SizedBox(),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.location_on_outlined,
                                      color: AppColors.whiteColor, size: 20),
                                  SizedBox(
                                    width: Get.width * 0.8,
                                    child: TextViewWidget(
                                      controller.shopItem?.attractions ?? "",
                                      textColor: AppColors.whiteColor,
                                      maxLine: 3,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  leading: GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(Icons.arrow_back,
                        color: innerBoxIsScrolled ? null : Colors.white),
                  ),
                  actions: [
                    Obx(() => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RoundedIconWidget(
                        icon: controller.isFavourite.value ? Icon(Icons.favorite):Icon(Icons.favorite_border),
                        contentPadding: 8,
                        onClickIcon: () => controller.setFavourite(),
                        backgroundColor: AppColors.primaryColor.withOpacity(0.4),
                      ),
                    ))
                  ],
                ),
                SliverPersistentHeader(
                  delegate: SliverAppBarDelegate(
                      TabBar(
                          onTap: (index) {

                          },
                          labelColor: AppColors.blackColor,
                          indicator: const CustomTabIndicator(),
                          isScrollable: true,
                          tabs: [
                            Tab(
                              height: 52,
                              text: AppString.aboutTxt.tr,
                            ),
                            Tab(height: 52, text: AppString.galleryTxt.tr,),
                            Tab(height: 52, text: AppString.reviewAndRatingTxt.tr,)
                          ]),
                      height: 54),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(() => ListView(
                      children: [
                        ListTile(
                          dense: true,
                          title: TextViewWidget(
                            AppString.descriptionText.tr,
                            textSize: 16,
                            fontWeight: FontWeight.bold,
                            textColor: AppColors.primaryColor,
                          ),
                          subtitle: TextViewWidget(
                              "${controller.shopItem?.description}"),
                        ),
                        ListTile(
                          dense: true,
                          title: TextViewWidget(
                            AppString.websiteText.tr,
                            textSize: 16,
                            fontWeight: FontWeight.bold,
                            textColor: AppColors.primaryColor,
                          ),
                          subtitle:
                              TextViewWidget("${controller.shopItem?.website}"),
                        ),
                        ListTile(
                          dense: true,
                          title: TextViewWidget(
                            AppString.contactText.tr,
                            textSize: 16,
                            fontWeight: FontWeight.bold,
                            textColor: AppColors.primaryColor,
                          ),
                          subtitle: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    size: 20,
                                    color: AppColors.primaryColor,
                                  ),
                                  TextViewWidget(
                                      " - ${controller.shopItem?.phone}")
                                ],
                              ),
                              SizedBox(
                                height: AppDimens.MARGIN_SMALL,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.email_rounded,
                                    size: 20,
                                    color: AppColors.primaryColor,
                                  ),
                                  TextViewWidget(
                                      " - ${controller.shopItem?.email}")
                                ],
                              ),
                              SizedBox(
                                height: AppDimens.MARGIN_SMALL,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 20,
                                    color: AppColors.primaryColor,
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.8,
                                    child: TextViewWidget(
                                        " - ${controller.shopItem?.attractions}"),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: AppDimens.MARGIN_CARD_MEDIUM_2,
                              ),
                              controller.isMapVisible.value
                                  ? AnimatedContainer(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              controller.mapHeightFactor.value,
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.fastOutSlowIn,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal:
                                              AppDimens.MARGIN_CARD_MEDIUM),
                                      decoration: BoxDecoration(
                                        color: AppColors.lightBlueColor2,
                                        borderRadius: BorderRadius.circular(
                                            AppDimens.MARGIN_MEDIUM),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            AppDimens.MARGIN_MEDIUM),
                                        child: GoogleMap(
                                            initialCameraPosition:
                                                controller.initialLocation,
                                            compassEnabled: true,
                                            myLocationButtonEnabled: true,
                                            myLocationEnabled: false,
                                            zoomControlsEnabled: false,
                                            zoomGesturesEnabled: true,
                                            markers: <Marker>{
                                              controller.markers
                                            },
                                            mapType: MapType.normal,
                                            onMapCreated:
                                                controller.onMapCreate,
                                            onTap: (LatLng location) =>
                                                controller.mapHeightFactor
                                                    .value = 0.5),
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        )
                      ],
                    )),
              ),
              ShopGalleryWidget(
                gallery: controller.shopItem?.gallery,
              ),
              controller.mainHomeController.isLogin.value?    RatingAndReviewWidget(shopReviewList: controller.reviewList): Center(child: TextViewWidget("Please login to continue"))
            ]),
          ),
          floatingActionButton: controller.mainHomeController.isLogin.value? FloatingActionButton.extended(
              onPressed: () => showDialog(
                    context: context,
                    builder: (_) {
                      return WriteReviewDialog(
                        title: AppString.leaveAReview.tr,
                        productId: controller.shopItem?.id?.toInt(),
                        shopDetailController: controller,
                      );
                    },
                  ),
              backgroundColor: AppColors.primaryColor,
              label: Row(
                children: [
                  Text(AppString.writeAReview.tr),
                  SizedBox(
                    width: 4,
                  ),
                  Icon(
                    Icons.edit,
                    size: 18,
                  ),
                ],
              )
          ):null
      ),
    );
  }
}

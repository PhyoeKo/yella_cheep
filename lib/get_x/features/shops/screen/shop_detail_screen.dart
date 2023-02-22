import 'package:cached_network_image/cached_network_image.dart';
import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/core/base/base_view.dart';
import 'package:explore_places/get_x/features/shops/controller/shop_controller.dart';
import 'package:explore_places/get_x/widget/cached_network_image_widget.dart';
import 'package:explore_places/get_x/widget/default_app_bar_widget.dart';
import 'package:explore_places/get_x/widget/text_view_widget.dart';
import 'package:explore_places/utils/Extensions/Widget_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/preferred_size.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../../../../utils/AppColor.dart';
import '../../../../utils/Extensions/text_styles.dart';

class ShopDetailScreen extends BaseView<ShopController> {
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
          physics: NeverScrollableScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                floating: true,
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
                            imageUrl: '/storage/shop/91676351357.jpeg',
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
                            // ratingWidget((placeModel!.rating ?? 0).toDouble())
                            //     .visible(!widget.isRequestPlace),
                            // 12.height,
            SizedBox(height: 12,),
                           TextViewWidget("Domino",textColor: AppColors.whiteColor,),

                            Row(
                              children: [
                                Icon(Icons.location_on_outlined,
                                    color: AppColors.whiteColor, size: 20),

            TextViewWidget("Address",textColor: AppColors.whiteColor,),

                              ],
                            ),
                            // if (appStore.currentPosition != null)
                            //   Row(
                            //     children: [
                            //       ImageIcon(AssetImage(ic_distance),
                            //           color: whiteColor, size: 20),
                            //       4.width,
                            //       Text(
                            //         '${calculateDistanceKm(appStore.currentPosition!.latitude, appStore.currentPosition!.longitude, placeModel!.latitude, placeModel!.longitude).toStringAsFixed(2)} ${language.km}',
                            //         style:
                            //             secondaryTextStyle(color: whiteColor),
                            //       ),
                            //     ],
                            //   ).paddingTop(8),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                leading: GestureDetector(
                  onTap: ()=> Get.back(),
                  child: Icon(Icons.arrow_back,
                          color: innerBoxIsScrolled ? null : Colors.white),
                )
                  ,
                actions: [
                  GestureDetector(
                      onTap: () {

                      },
                      child: Icon(Icons.favorite),)
                ],
              ),
            ];
          },
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBar(
                tabs: [
                  Tab(text: "About Us"),
                  Tab(text: "Gallery"),
                  Tab(text: "Review"),
                ],
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: AppColors.primaryColor,
                labelStyle: boldTextStyle(color: AppColors.primaryColor),
                unselectedLabelStyle: primaryTextStyle(),
              ),
              TabBarView(children: [
                TextViewWidget("About us",textColor: AppColors.primaryColor,),
                TextViewWidget("Gallery"),
                TextViewWidget("Review"),
                // HistoryComponent(place: placeModel!),
                // GalleryComponent(place: placeModel!),
                // ReviewComponent(
                //     place: placeModel!,
                //     onUpdate: (value) {
                //       placeModel!.rating = value;
                //       setState(() {});
                //     }).visible(!widget.isRequestPlace),
              ]).expand(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          mini: true,
          backgroundColor: primaryColor,
          child: Icon(Icons.location_pin, color: Colors.white),
          onPressed: () {
            MapsLauncher.launchCoordinates(
                16.823355, 96.154237);
          },
        ),
      ),
    );
  }
}

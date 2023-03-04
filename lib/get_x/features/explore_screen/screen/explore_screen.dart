import 'package:explore_places/get_x/constant/enum/shop_type_enum.dart';
import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/constant/routing/app_route.dart';
import 'package:explore_places/get_x/core/base/base_view.dart';
import 'package:explore_places/get_x/core/services/dio_provider.dart';
import 'package:explore_places/get_x/core/utils/app_utils.dart';
import 'package:explore_places/get_x/features/explore_screen/controller/explore_controller.dart';
import 'package:explore_places/get_x/widget/app_bar/cupertino_sliver_app_bar.dart';
import 'package:explore_places/get_x/widget/default_app_bar_widget.dart';
import 'package:explore_places/utils/Common.dart';
import 'package:explore_places/utils/Extensions/Constants.dart';
import 'package:explore_places/utils/Extensions/Widget_extensions.dart';
import 'package:explore_places/utils/Extensions/decorations.dart';
import 'package:explore_places/utils/Extensions/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ExploreScreen extends BaseView<ExploreController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            CupertinoSliverAppBar(
              title: 'Explore'.tr,
            ),
          ];
        },
        body: Obx(
          () => controller.homeController.stateList.isNotEmpty
              ? AnimationLimiter(
                  child: GridView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: controller.homeController.stateList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16),
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredGrid(
                        columnCount: 1,
                        duration: Duration(milliseconds: 1000),
                        position: index,
                        child: ScaleAnimation(
                          scale: 0.5,
                          child: FadeInAnimation(
                            child: GestureDetector(
                              onTap: () {
                                AppUtils.selectedID = controller
                                    .homeController.stateList[index].id;
                                Get.toNamed(
                                  Routes.shopList,
                                  arguments: ShopType.byState,
                                );
                              },
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  cachedImage(
                                    "${DioProvider.baseUrl}${controller.homeController.stateList[index].image}",
                                    fit: BoxFit.cover,
                                  ).cornerRadiusWithClipRRect(defaultRadius),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: radius(defaultRadius),
                                        border: Border.all(
                                            color: Colors.transparent),
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.black.withOpacity(0.1),
                                              Colors.black.withOpacity(0.1),
                                              Colors.black.withOpacity(0.1),
                                              Colors.black.withOpacity(0.9),
                                            ])),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      controller.homeController.stateList[index]
                                              .name ??
                                          "",
                                      style: boldTextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                    ).paddingOnly(bottom: 8, left: 8, right: 8),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  enabled: true,
                  child: GridView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: 10,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16),
                    itemBuilder: (context, index) {
                      return Container(
                        width: 200,
                        height: 250,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: radius(defaultRadius),
                        ),
                      );
                    },
                  ),
                ),
        ));
  }
}

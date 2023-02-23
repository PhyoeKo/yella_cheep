import 'package:explore_places/get_x/core/base/base_view.dart';
import 'package:explore_places/get_x/features/explore_screen/controller/explore_controller.dart';
import 'package:explore_places/get_x/widget/default_app_bar_widget.dart';
import 'package:explore_places/utils/Common.dart';
import 'package:explore_places/utils/Extensions/Constants.dart';
import 'package:explore_places/utils/Extensions/Widget_extensions.dart';
import 'package:explore_places/utils/Extensions/decorations.dart';
import 'package:explore_places/utils/Extensions/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class ExploreScreen extends BaseView<ExploreController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return DefaultAppBar(title: "States");
  }

  @override
  Widget body(BuildContext context) {
    return Obx(() => AnimationLimiter(
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
                        //  ViewAllScreen(name: item.name.validate(),stateId: item.id).launch(context);
                      },
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          cachedImage(
                            controller.homeController.stateList[index].image,
                            fit: BoxFit.cover,
                          ).cornerRadiusWithClipRRect(defaultRadius),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: radius(defaultRadius),
                                border: Border.all(color: Colors.transparent),
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
                              controller.homeController.stateList[index].name??"",
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
        ));
  }
}

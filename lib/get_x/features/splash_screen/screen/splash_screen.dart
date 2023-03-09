import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/constant/resources/app_string.dart';
import 'package:explore_places/get_x/core/base/base_view.dart';
import 'package:explore_places/get_x/features/splash_screen/controller/splash_screen_controller.dart';
import 'package:explore_places/get_x/widget/text_view_widget.dart';
import 'package:explore_places/utils/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SplashScreen extends BaseView<SplashScreenController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          splash_screen_image,
          fit: BoxFit.fitHeight,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            width: Get.width *0.6,
            height: Get.width *0.2,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: AppColors.whiteColor.withOpacity(0.5)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                LoadingIndicator(
                    indicatorType: Indicator.lineScalePulseOut,

                    /// Required, The loading type of the widget
                    colors: const [Colors.red,Colors.yellow,Colors.blue],

                    /// Optional, The color collections
                    strokeWidth: 2,

                    /// Optional, The stroke of the line, only applicable to widget which contains line


                    /// Optional, the stroke backgroundColor
                    ),
                TextViewWidget(AppString.gettingReadyTxt.tr,textSize: 18,fontWeight: FontWeight.bold,)
              ],
            ),
          ),
        )
      ],
    );
  }
}

import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/constant/routing/app_route.dart';
import 'package:explore_places/get_x/widget/secondary_button_widget.dart';
import 'package:explore_places/get_x/widget/text_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GoLoginWidget extends StatelessWidget {
  final String desc;
  final String title;

  const GoLoginWidget({Key? key, required this.desc, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextViewWidget(
          title,
          fontWeight: FontWeight.bold,
          textColor: AppColors.blackColor,
          textSize: 18,
        ),
        SizedBox(
          height: 6,
        ),
        TextViewWidget(
          desc,
          fontWeight: FontWeight.normal,
        ),
        SizedBox(
          height: 6,
        ),
        MaterialButton(
          onPressed: () => Get.toNamed(Routes.login),
          child: TextViewWidget("Login"),
          color: AppColors.whiteColor,
          highlightElevation: 5,
          highlightColor: AppColors.primaryColor.withOpacity(0.1),
          splashColor: AppColors.primaryColor.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(
              width: 0,
              color: AppColors.lightBlueColor2,
            ),
          ),
        )
      ],
    );
  }
}

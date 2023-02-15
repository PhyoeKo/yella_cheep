import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yella_merchant/constant/resources/app_dimens.dart';

import '../constant/resources/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonText;
  final Function onTabMovie;
  final double buttonTextPadding;

  const PrimaryButton(this.buttonText, this.onTabMovie,
      {this.buttonTextPadding = 0.0});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: flatButtonStyle,
      onPressed: () {
        onTabMovie();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: buttonTextPadding),
        child: Text(
          buttonText.tr,
          style: const TextStyle(color: Colors.white,fontSize: 18),
        ),
      ),
    );
  }
}

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  foregroundColor: AppColors.primaryColor, minimumSize: Size(Get.width, AppDimens.MARGIN_MEDIUM * 6),
  padding: const EdgeInsets.symmetric(horizontal:AppDimens.MARGIN_MEDIUM * 2),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(
     4,
    )),
  ),
  backgroundColor: AppColors.searchFieldTextColor,
);

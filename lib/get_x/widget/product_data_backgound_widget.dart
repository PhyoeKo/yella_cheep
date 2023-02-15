
import 'package:flutter/material.dart';
import 'package:yella_merchant/constant/resources/app_colors.dart';
import 'package:yella_merchant/constant/resources/app_dimens.dart';

class ProductDataBackground extends StatelessWidget {
  final Widget widget;
  final Color backgroundColor;
  final double margin;
  final double horizontalPadding;
  final double verticalPadding;

  const ProductDataBackground(
      {Key? key,
      required this.widget,
      this.backgroundColor = AppColors.whiteColor,
      this.margin = 16,
      this.horizontalPadding = AppDimens.MARGIN_MEDIUM_2,
        this.verticalPadding = AppDimens.MARGIN_MEDIUM_2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: margin),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding,vertical: verticalPadding), //AppDimens.MARGIN_MEDIUM_2
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius:
              BorderRadius.all(const Radius.circular(AppDimens.MARGIN_MEDIUM))),
      child: widget,
    );
  }
}

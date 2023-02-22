import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/constant/resources/app_dimens.dart';
import 'package:explore_places/get_x/widget/text_view_widget.dart';
import 'package:flutter/material.dart';


class CustomChipWidget extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final bool isBold;

  const CustomChipWidget(
      {Key? key,
      required this.text,
      this.backgroundColor = AppColors.appBarColor,
      this.textColor = AppColors.whiteColor,
      this.isBold = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: AppDimens.MARGIN_SMALL,
          horizontal: AppDimens.MARGIN_SMALL + AppDimens.MARGIN_EXTRA_SMALL),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: backgroundColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextViewWidget(
            text,
            textColor: textColor,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.normal,
            textSize: 12,
          ),
        ],
      ),
    );
  }
}

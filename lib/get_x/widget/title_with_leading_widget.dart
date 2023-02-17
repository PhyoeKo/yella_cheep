import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/constant/resources/app_dimens.dart';
import 'package:explore_places/get_x/widget/text_view_widget.dart';
import 'package:flutter/material.dart';


class TitleWithLeadingWidget extends StatelessWidget {
  final String? title;
  final FontWeight? titleFontWeight;
  final Color? leadingIconColor;

  const TitleWithLeadingWidget({
    Key? key,
    @required this.title,
    this.titleFontWeight = FontWeight.w400,
    this.leadingIconColor = AppColors.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          size: 8,
          color: leadingIconColor,
        ),
        const SizedBox(
          width: AppDimens.MARGIN_SMALL,
        ),
        TextViewWidget(title!,
            textSize: AppDimens.TEXT_REGULAR,
            textColor: AppColors.textColorGreyDark,
            fontWeight: titleFontWeight)
      ],
    );
  }
}

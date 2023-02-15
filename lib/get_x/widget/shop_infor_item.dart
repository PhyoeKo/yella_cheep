
import 'package:flutter/material.dart';
import 'package:yella_merchant/constant/resources/app_colors.dart';
import 'package:yella_merchant/constant/resources/app_dimens.dart';
import 'package:yella_merchant/widget/text_view_widget.dart';
import 'package:yella_merchant/widget/title_with_leading_widget.dart';

class ShopInfoItem extends StatelessWidget {
  final String title;
  final String description;

  const ShopInfoItem({
    required this.title,
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppDimens.MARGIN_SMALL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: TitleWithLeadingWidget(
                  title: title,
                  titleFontWeight: FontWeight.w400,

                ),
              ),
              Expanded(
                flex: 2,
                child: TextViewWidget(
                  description,
                  textSize: AppDimens.TEXT_REGULAR,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.textColorBlueGreyDark,
                ),
              )
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}

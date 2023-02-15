import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yella_merchant/constant/resources/app_colors.dart';
import 'package:yella_merchant/constant/resources/app_dimens.dart';
import 'package:yella_merchant/widget/text_view_widget.dart';


class TodaySaleItemWidget extends StatelessWidget {
  final String title;
  final String amount;
  final String unit;
  final Color verticalDividerColor;

  const TodaySaleItemWidget({
    Key? key,
    required this.title,
    required this.amount,
    required this.unit,
    required this.verticalDividerColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppDimens.MARGIN_MEDIUM_2,
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            VerticalDivider(
              color: verticalDividerColor,
              thickness: 2,
              width: 0,
            ),
            SizedBox(
              width: AppDimens.MARGIN_MEDIUM_2,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical:  AppDimens.MARGIN_MEDIUM_2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextViewWidget(title,
                      textColor: AppColors.appBarTextColor,
                      textSize: 16,
                      letterSpacing: 0.2,
                      fontWeight: FontWeight.w400),
                  SizedBox(
                    height:  AppDimens.MARGIN_MEDIUM_2,
                  ),
                  Row(
                    children: [
                      TextViewWidget(
                        amount,
                        textSize: AppDimens.TEXT_REGULAR,
                        textColor: AppColors.secondaryColor,
                        letterSpacing: 0.2,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(width: AppDimens.MARGIN_MEDIUM),
                      TextViewWidget(unit.tr,
                          textColor: AppColors.appBarTextColor,
                          textSize: AppDimens.MARGIN_MEDIUM_2),
                      SizedBox(
                        width: AppDimens.MARGIN_MEDIUM_2,
                      ),
                      // SvgPicture.asset(
                      //   AppImages.icVector,
                      //   width: SizeConfig.margin12dp,
                      //   height: SizeConfig.margin12dp,
                      // )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

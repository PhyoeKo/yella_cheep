
import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/constant/resources/app_dimens.dart';
import 'package:explore_places/get_x/widget/show_image_widget.dart';
import 'package:explore_places/get_x/widget/text_view_widget.dart';
import 'package:flutter/material.dart';


class ShopListItemWidget extends StatelessWidget {
  final String shopImage;
  final String shopName;
  final String shopDescription;
  final String shopAddress;
  final String time;

  const ShopListItemWidget({
    Key? key,
    required this.shopImage,
    required this.shopName,
    required this.shopDescription,
    required this.shopAddress,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.MARGIN_CARD_MEDIUM),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShowRoundedImageWidget(
            imagePath: shopImage,
            width: 80,
            height: 80,
            cornerRadius: 8,
          ),
          const SizedBox(
            width: AppDimens.MARGIN_CARD_MEDIUM,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextViewWidget(
                  shopName,
                  textSize: AppDimens.TEXT_REGULAR_3X,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.primaryColor,
                ),
                const SizedBox(
                  height: AppDimens.MARGIN_SMALL,
                ),
                TextViewWidget(
                  shopAddress,
                  textSize: AppDimens.TEXT_REGULAR,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.textColorBlueGreyDark,
                ),
                const SizedBox(
                  height: AppDimens.MARGIN_MEDIUM,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

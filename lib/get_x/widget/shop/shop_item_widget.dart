import 'package:explore_places/get_x/constant/enum/shop_type_enum.dart';
import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/constant/resources/app_dimens.dart';
import 'package:explore_places/get_x/constant/routing/app_route.dart';
import 'package:explore_places/get_x/data_models/responses/shop_data_response.dart';
import 'package:explore_places/get_x/widget/cached_network_image_widget.dart';
import 'package:explore_places/get_x/widget/custom_chip_widget.dart';
import 'package:explore_places/get_x/widget/text_view_widget.dart';
import 'package:explore_places/utils/Common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopItemWidget extends StatelessWidget {
  final ShopDataResponse shopItem;

  const ShopItemWidget({Key? key, required this.shopItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.shopDetail,
          arguments:  shopItem),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.MARGIN_SMALL),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppDimens.MARGIN_MEDIUM),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CachedNetworkImageWidget(
                  imageUrl: shopItem.image1,
                  boxFit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.36,
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
              ),
            ),
            Positioned(
              left: 10,
              right: 10,
              top: 10,
              child: Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  ratingWidget((shopItem.discount ??
                      "")),
                ],
              ),
            ),
            shopItem.distance != null
                ? Positioned(
                    top: AppDimens.MARGIN_CARD_MEDIUM,
                    right: AppDimens.MARGIN_CARD_MEDIUM_2,
                    child:
                        CustomChipWidget(text: "${shopItem.distance} Km away"))
                : SizedBox(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: AppColors.appBarColor,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                height: 60,
                width: 230,
                child: Column(
                  children: [
                    TextViewWidget(
                      shopItem.name ?? "",
                      textColor: AppColors.whiteColor,
                      fontWeight: FontWeight.w500,
                    ),
                    TextViewWidget(
                      shopItem.description ?? "",
                      textColor: AppColors.whiteColor,
                      textSize: 10,
                      maxLine: 2,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

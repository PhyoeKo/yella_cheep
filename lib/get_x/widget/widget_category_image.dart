import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/constant/resources/app_dimens.dart';
import 'package:explore_places/get_x/widget/cached_network_image_widget.dart';
import 'package:explore_places/get_x/widget/text_view_widget.dart';
import 'package:explore_places/utils/Common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryImageWidget extends StatelessWidget {
  const CategoryImageWidget({
    required this.image,
    required this.name,

    Key? key,
  }) : super(key: key);

  final String image, name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimens.MARGIN_MEDIUM),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppDimens.MARGIN_MEDIUM),
            child: CachedNetworkImageWidget(
              imageUrl: image,
              boxFit: BoxFit.cover,
              width: 100,
              height: 100,
            ),
          ),
        ),
        TextViewWidget(name)
      ],
    );
  }
}

class HomeCategoryWidget extends StatelessWidget {
  const HomeCategoryWidget({
    required this.image,
    required this.name,
    required this.discount,
    required this.state,
    Key? key,
  }) : super(key: key);

  final String image, name,discount,state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimens.MARGIN_MEDIUM),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppDimens.MARGIN_MEDIUM),
            child: CachedNetworkImageWidget(
              imageUrl: image,
              boxFit: BoxFit.cover,
              width: Get.width * 0.5,
              height: Get.height * 0.23,
            ),
          ),
        ),
        SizedBox(height: 4,),
        ratingWidget((discount ??
            "")),
        SizedBox(height: 4,),

        TextViewWidget(name,textColor: AppColors.blackColor,maxLine: 1,),
        SizedBox(height: 4,),

        TextViewWidget(state,textColor: AppColors.blackColor,maxLine: 1)
      ],
    );
  }
}

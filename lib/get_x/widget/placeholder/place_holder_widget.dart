import 'package:explore_places/get_x/constant/resources/app_images.dart';
import 'package:explore_places/get_x/widget/text_view_widget.dart';
import 'package:flutter/material.dart';

class PlaceHolderWidget extends StatelessWidget {
  final String image;
  final String title;
  final double topPadding;

  const PlaceHolderWidget(
      {Key? key,
      this.image = AppImages.noDataImage,
      this.title = "No data",
      this.topPadding = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: topPadding,
        ),
        Image.asset(
          image,
          width: 120,
          height: 120,
        ),
        TextViewWidget(
          title,
          textSize: 16,
        )
      ],
    );
  }
}

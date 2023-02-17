import 'package:explore_places/get_x/constant/resources/app_dimens.dart';
import 'package:explore_places/get_x/widget/text_view_widget.dart';
import 'package:flutter/material.dart';


class TitleSection extends StatelessWidget {
  final AnimationController animationController;
  const TitleSection(
      {Key? key, required this.animationController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
     final _enterAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.2,
        0.4,
        curve: Curves.elasticInOut,
      ),
    ));

    return ScaleTransition(
      scale: _enterAnimation,
      child: const TextViewWidget(
        "HoHo DiDi",
            textColor: Colors.white,
        fontWeight: FontWeight.bold,
        textSize: AppDimens.TEXT_HEADING_1X,
      ),
    );
  }
}


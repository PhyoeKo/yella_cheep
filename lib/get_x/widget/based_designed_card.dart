import 'dart:ui';

import 'package:explore_places/get_x/constant/resources/app_dimens.dart';
import 'package:flutter/material.dart';

class BasedDesignedCard extends StatelessWidget {
  final Color color;
  final Widget child;
  const BasedDesignedCard({
    Key? key,
    required this.color,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimens.MARGIN_CARD_MEDIUM),
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.MARGIN_MEDIUM_2),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(AppDimens.MARGIN_CARD_MEDIUM)),
          color: color.withOpacity(0.9)),
      child: child,
    );
  }
}

import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:flutter/material.dart';

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  double height;

  SliverAppBarDelegate(
    this.tabBar, {
    this.height = 48,
  });

  final Widget? tabBar;

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      elevation: 2,
      child: Container(
        decoration:  const BoxDecoration(
          color: AppColors.appBarIconColor
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.white,
            //     blurRadius: 15,
            //   ),
            // ]
        ),
        child: tabBar,
      ),
    );
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return true;
  }
}




import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/core/utils/custom_tab_indicator.dart';
import 'package:explore_places/get_x/core/utils/sliver_app_delegete.dart';
import 'package:explore_places/get_x/features/category/controller/category_controller.dart';
import 'package:explore_places/get_x/widget/default_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/preferred_size.dart';

import '../../../core/base/base_view.dart';

class CategoryScreen extends BaseView<CategoryController>{
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return DefaultAppBar(title: 'Explore',);
  }

  @override
  Widget body(BuildContext context) {
    return  DefaultTabController(
      length: controller.categoryList.length,
      child: NestedScrollView(
        headerSliverBuilder:
            (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverPersistentHeader(
              delegate: SliverAppBarDelegate(
                  TabBar(
                    controller: controller.tabController,
                    isScrollable: true,
                    labelColor: AppColors.blackColor,
                    indicator: const CustomTabIndicator(),
                    tabs: controller.categoryList
                        .map(
                          (item) => Tab(height: 52, text: item.name),
                    )
                        .toList(),
                  ),
                  height: 48),
              pinned: true,
            ),
          ];
        },
        body: TabBarView(
          controller: controller.tabController,
          children:controller.categoryList
              .map((item) => Text(""))
              .toList(),
        ),
      ),
    );
  }

}
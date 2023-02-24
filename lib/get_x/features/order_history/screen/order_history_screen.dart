import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/core/base/base_view.dart';
import 'package:explore_places/get_x/features/order_history/controller/order_history_controller.dart';
import 'package:explore_places/get_x/widget/default_app_bar_widget.dart';
import 'package:explore_places/get_x/widget/order_item_widget.dart';
import 'package:explore_places/get_x/widget/text_view_widget.dart';
import 'package:explore_places/get_x/widget/view_handling/smart_refresher_parent_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/preferred_size.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class OrderHistoryScreen extends BaseView<OrderHistoryController> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  OrderHistoryScreen({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return const DefaultAppBar(title: "Order History");
  }

  @override
  Widget body(BuildContext context) {
    return Obx(() => SmartRefresherParentView(
          refreshController: _refreshController,
          enablePullUp: true,
          onRefresh: () => controller.resetAndGetPendingOrderList(
              refreshController: _refreshController),
          onLoading: () => controller.getOrderList(
              refreshController: _refreshController),
          child: CustomScrollView(
            slivers: [
              // SliverToBoxAdapter(
              //   child: Container(
              //     padding: const EdgeInsets.all(8),
              //     color: AppColors.canvasColor,
              //     child: TextViewWidget("Filter Box"),
              //   ),
              // ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return OrderItemWidget(
                        orderData: controller.orderList[index]);
                  },
                  childCount: controller.orderList.length,
                ),
              ),
            ],
          ),
        ));
  }
}

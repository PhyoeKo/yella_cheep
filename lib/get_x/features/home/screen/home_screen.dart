import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/constant/resources/app_dimens.dart';
import 'package:explore_places/get_x/constant/routing/app_route.dart';
import 'package:explore_places/get_x/core/base/base_view.dart';
import 'package:explore_places/get_x/core/utils/number_format_utils.dart';
import 'package:explore_places/get_x/data_models/responses/shop_data_ob.dart';
import 'package:explore_places/get_x/features/home/controller/home_controller.dart';
import 'package:explore_places/get_x/widget/default_app_bar_widget.dart';
import 'package:explore_places/get_x/widget/order_item_widget.dart';
import 'package:explore_places/get_x/widget/text_view_widget.dart';
import 'package:explore_places/get_x/widget/view_handling/smart_refresher_parent_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/preferred_size.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class HomeScreen extends BaseView<HomeController> {
  HomeScreen({super.key});

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return const DefaultAppBar(title: "Home");
  }

  @override
  Widget? floatingActionButton() {
    return FloatingActionButton(
      onPressed: () => Get.toNamed(
        Routes.scanQRScreen,
      ),
      child: Icon(Icons.document_scanner_sharp),
    );
  }

  @override
  Widget body(BuildContext context) {
    return Obx(() => SmartRefresherParentView(
          refreshController: _refreshController,
          enablePullUp: true,
          onRefresh: () => controller.resetAndGetCancelOrderList(
              refreshController: _refreshController),
          onLoading: () => controller.getOrderList(),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimens.MARGIN_MEDIUM_2),
                  child: IntrinsicHeight(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius:
                            BorderRadius.circular(AppDimens.MARGIN_MEDIUM_2),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: AppDimens.MARGIN_MEDIUM_2),

                          const SizedBox(
                            width: AppDimens.MARGIN_10,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextViewWidget(
                    "Today Sale",
                    textSize: 18,
                    fontWeight: FontWeight.bold,
                    textColor: AppColors.primaryColor,
                  ),
                ),
              ),
              controller.orderList.isNotEmpty
                  ? SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return OrderItemWidget(
                            orderData: controller.orderList[index],
                          );
                        },
                        childCount: controller.orderList.length,
                      ),
                    )
                  : const SliverToBoxAdapter(
                      child: Center(
                          child: TextViewWidget(
                        "No invoices for today",
                        textSize: 18,
                      )),
                    ),
            ],
          ),
        ));
  }
}

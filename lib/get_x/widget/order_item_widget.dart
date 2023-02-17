import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/core/utils/date_utils.dart';
import 'package:explore_places/get_x/core/utils/dialog_utils.dart';
import 'package:explore_places/get_x/data_models/responses/order_history_response.dart';
import 'package:explore_places/get_x/widget/text_view_widget.dart';
import 'package:flutter/material.dart';


class OrderItemWidget extends StatelessWidget {
  final OrderHistoryResponse orderData;

  const OrderItemWidget({Key? key, required this.orderData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: ()=> context.showOrderInfoDialog(orderHistoryResponse: orderData),
          child: ListTile(
            leading: const Icon(Icons.library_books_outlined),
            dense: true,
            title: TextViewWidget(
              "Order Id: 0000${orderData.id}",
              fontWeight: FontWeight.bold,
            ),
            subtitle: TextViewWidget(
              "Total price: ${orderData.price! - (orderData.price! - orderData.discountPrice!)}",
              textColor: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              textSize: 16,
            ),
            trailing: TextViewWidget(DateUtil.convertTimeAgoFromTimestamp(
              orderData.orderDate ?? "",
            )),
          ),
        ),
        const Divider(
          color: AppColors.lightGreyColor,
          thickness: 1,
        ),
      ],
    );
  }
}




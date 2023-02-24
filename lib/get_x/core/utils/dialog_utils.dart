import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/constant/resources/app_dimens.dart';
import 'package:explore_places/get_x/core/utils/date_utils.dart';
import 'package:explore_places/get_x/data_models/responses/order_history_response.dart';
import 'package:explore_places/get_x/widget/secondary_button_widget.dart';
import 'package:explore_places/get_x/widget/text_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';


extension Context on BuildContext {
  showPromptDialog({
    required String title,
    String okBtnText = "Yes",
    String cancelBtnText = 'No',
    String content = "This is Content",
    bool showNegativeButton = true,
    required Function okBtnFunction,
  }) {
    Get.dialog(Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.MARGIN_MEDIUM)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: AppDimens.MARGIN_MEDIUM),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppDimens.MARGIN_MEDIUM),
                  topRight: Radius.circular(AppDimens.MARGIN_MEDIUM)),
            ),
            width: double.infinity,
            child: Center(
              child: TextViewWidget(
                title,
                textColor: Colors.white,
                textSize: 18.0,
                textOverflow: null,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: AppDimens.MARGIN_CARD_MEDIUM,
              left: AppDimens.MARGIN_MEDIUM_2,
            ),
            alignment: Alignment.centerLeft,
            child: TextViewWidget(
              content,
              textColor: AppColors.textColorBlueGreyDark,
              textSize: 16.0,
              textOverflow: null,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              showNegativeButton
                  ? TextButton(
                      child: TextViewWidget(
                        cancelBtnText,
                        textColor: AppColors.textColorBlueGreyDark,
                        textSize: 16.0,
                      ),
                      onPressed: () => Get.back())
                  : const SizedBox(),
              TextButton(
                child: TextViewWidget(
                  okBtnText,
                  textColor: AppColors.primaryColor,
                  textSize: 16.0,
                ),
                onPressed: () => okBtnFunction(),
              )
            ],
          ),
          SizedBox(
            height: 2,
          )
        ],
      ),
    ));
  }

  showOrderInfoDialog({required OrderHistoryResponse orderHistoryResponse}) {
    return Get.dialog(Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.MARGIN_MEDIUM)),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: AppDimens.MARGIN_CARD_MEDIUM,
            horizontal: AppDimens.MARGIN_MEDIUM),
        height: Get.height * 0.4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: TextViewWidget(
                "Invoice number: 000${orderHistoryResponse.id} ",
                fontWeight: FontWeight.w500,
                textSize: 16,
              ),
            ),
            const SizedBox(
              height: AppDimens.MARGIN_MEDIUM,
            ),
            Center(
              child: TextViewWidget(
                "${DateUtil.convertDateFormat(orderHistoryResponse.orderDate ?? "", DAY_MONTH_YEAR_HH_MM_SS)} ",
                textSize: 12,
              ),
            ),
            const SizedBox(
              height: AppDimens.MARGIN_CARD_MEDIUM,
            ),
            ListTile(
              dense: true,
              //  leading: Icon(Icons.person),
              title: TextViewWidget(
                "Shop Name: ${orderHistoryResponse.name}",
              ),
              subtitle: TextViewWidget(
                "Phone: ${orderHistoryResponse.phone}",
                textSize: 12,
              ),
            ),
            const Divider(
              color: AppColors.lightGreyColor,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.MARGIN_CARD_MEDIUM_2),
              child: Row(
                children: [
                  const TextViewWidget("Total spend :"),
                  Spacer(),
                  TextViewWidget(orderHistoryResponse.price.toString()),
                ],
              ),
            ),
            const Divider(
              color: AppColors.lightGreyColor,
              thickness: 1,
            ),
            Row(
              children: [
                const Spacer(),
                TextViewWidget(
                    "with discount ${orderHistoryResponse.discount} %"),
              ],
            ),
            const Divider(
              color: AppColors.canvasColorDark,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.MARGIN_CARD_MEDIUM_2),
              child: Row(
                children: [
                  const TextViewWidget(
                    "Net total: ",
                    fontWeight: FontWeight.bold,
                  ),
                  Spacer(),
                  TextViewWidget(orderHistoryResponse.discountPrice.toString(),
                      fontWeight: FontWeight.bold),
                ],
              ),
            ),
            Spacer(),
            Align(
                alignment: Alignment.bottomRight,
                child: SecondaryButtonWidget(
                  onPress: () => Get.back(),
                  child: TextViewWidget(
                    "OK",
                    textColor: AppColors.whiteColor,
                  ),
                ))
          ],
        ),
      ),
    ));
  }
}

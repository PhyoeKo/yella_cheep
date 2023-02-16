import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/constant/resources/app_dimens.dart';
import 'package:explore_places/get_x/core/base/base_view.dart';
import 'package:explore_places/get_x/features/home/controller/create_voucher_controller.dart';
import 'package:explore_places/get_x/widget/cached_network_image_widget.dart';
import 'package:explore_places/get_x/widget/custom_chip_widget.dart';
import 'package:explore_places/get_x/widget/default_app_bar_widget.dart';
import 'package:explore_places/get_x/widget/secondary_button_widget.dart';
import 'package:explore_places/get_x/widget/text_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class CreateVoucherScreen extends BaseView<CreateVoucherController> {
  CreateVoucherScreen({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return DefaultAppBar(title: "Create Invoice");
  }

  @override
  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Card(
            child: ListTile(
              leading: CachedNetworkImageWidget(
                imageUrl: controller.shopProfileResponse?.image1 ?? "",
              ),
              title: TextViewWidget(
                controller.shopProfileResponse?.name ?? "",
                textSize: 18,
                fontWeight: FontWeight.w500,
              ),
              subtitle: TextViewWidget(
                controller.shopProfileResponse?.description ?? "",
                fontWeight: FontWeight.w200,
              ),
              trailing: CustomChipWidget(
                text:
                    "Discount ${controller.shopProfileResponse?.discount ?? ""} %",
              ),
            ),
          ),
          const SizedBox(
            height: AppDimens.MARGIN_LARGE,
          ),
          TextField(
            controller: controller.totalAmountController,
            autofocus: false,
            keyboardType: TextInputType.number,
            onChanged: (text)=> controller.calculateAmount(text),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppDimens.MARGIN_MEDIUM),
                ),
                borderSide: BorderSide(color: AppColors.spaceWhiteColor),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppDimens.MARGIN_MEDIUM),
                ),
                borderSide: BorderSide(color: AppColors.spaceWhiteColor),
              ),
              filled: true,
              hintStyle: TextStyle(
                color: AppColors.textColor.withOpacity(
                  0.5,
                ),
                height: 1,
              ),
              hintText: "Enter total spend amount",
              contentPadding: const EdgeInsets.all(
                AppDimens.MARGIN_CARD_MEDIUM_2,
              ),
              fillColor: AppColors.spaceWhiteColor,
              //suffix: TextViewWidget("Apply ")
              // prefixIcon: Icon(Icons.person),
            ),
          ),
          const SizedBox(
            height: AppDimens.MARGIN_LARGE,
          ),
          Center(
            child: Obx(()=>TextViewWidget(
              "Applied ${controller.shopProfileResponse?.discount ?? ""} % discount = ${controller.netAmount.value}",
              textColor: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              textSize: 18,
            )),
          ),  const SizedBox(
            height: AppDimens.MARGIN_LARGE,
          ),
    SecondaryButtonWidget(onPress: ()=> controller.createInvoice(),child: TextViewWidget("Create Invoice",textColor: AppColors.whiteColor,fontWeight: FontWeight.w500,),)
        ],
      ),
    );
  }
}

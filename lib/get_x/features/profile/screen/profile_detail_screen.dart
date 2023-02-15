import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yella_merchant/constant/resources/app_colors.dart';
import 'package:yella_merchant/constant/resources/app_dimens.dart';
import 'package:yella_merchant/constant/routing/app_route.dart';
import 'package:yella_merchant/core/base/base_view.dart';
import 'package:yella_merchant/features/profile/controller/profile_controller.dart';
import 'package:yella_merchant/widget/default_app_bar_widget.dart';
import 'package:yella_merchant/widget/shop_infor_item.dart';
import 'package:yella_merchant/widget/shop_list_item_widget.dart';

class ProfileDetailScreen extends BaseView<ProfileController> {
  ProfileDetailScreen({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return DefaultAppBar(
      title: "Account Information",
      trillingIcon: Icons.edit_outlined,
       trillingIconOnClick: () => Get.toNamed(Routes.profileEdit),
    );
  }

  @override
  Color pageBackgroundColor() {
    // TODO: implement pageBackgroundColor
    return const Color(0xffE5E5E5);
  }

  @override
  Widget body(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: const BoxDecoration(color: AppColors.whiteColor),
          child: ShopListItemWidget(
            shopImage: controller.merchantProfileOb.value.image??"",
            shopName: controller.merchantProfileOb.value.name??"",
            shopDescription:
                controller.merchantProfileOb.value.description ?? "",
            shopAddress: controller.merchantProfileOb.value.state ?? "",
            time:
                "${controller.merchantProfileOb.value.shopEmail ?? ""} to ${controller.merchantProfileOb.value.shopPhone ?? ""}",
          ),
        ),
        const SizedBox(
          height: AppDimens.MARGIN_MEDIUM_2,
        ),
        DecoratedBox(
          decoration: const BoxDecoration(color: AppColors.whiteColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.MARGIN_MEDIUM_2,
                vertical: AppDimens.MARGIN_CARD_MEDIUM),
            child: Column(
              children: [
                ShopInfoItem(
                  title: "Phone",
                  description:
                      controller.merchantProfileOb.value.shopPhone ?? "",
                ),
                ShopInfoItem(
                  title: "Address",
                  description: controller.merchantProfileOb.value.website ?? "",
                ),
                ShopInfoItem(
                  title: "Description",
                  description:
                      controller.merchantProfileOb.value.description ?? "",
                ),
                ShopInfoItem(
                  title: "Remark",
                  description:
                      controller.merchantProfileOb.value.attractions ?? "",
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

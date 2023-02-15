import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/preferred_size.dart';
import 'package:get/get.dart';
import 'package:yella_merchant/constant/resources/app_colors.dart';
import 'package:yella_merchant/constant/resources/app_dimens.dart';
import 'package:yella_merchant/constant/routing/app_route.dart';
import 'package:yella_merchant/core/base/base_view.dart';
import 'package:yella_merchant/core/utils/app_utils.dart';
import 'package:yella_merchant/core/utils/dialog_utils.dart';
import 'package:yella_merchant/features/profile/controller/profile_controller.dart';
import 'package:yella_merchant/widget/default_app_bar_widget.dart';
import 'package:yella_merchant/widget/show_image_widget.dart';
import 'package:yella_merchant/widget/text_view_widget.dart';

class ProfileScreen extends BaseView<ProfileController> {
  ProfileScreen({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return DefaultAppBar(title: "Profile");
  }

  @override
  Widget body(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Stack(
            children: [
              Container(
                constraints: BoxConstraints(
                    minHeight: Get.height * 0.15,
                    minWidth: double.infinity,
                    maxHeight: 400),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Color(0xFF38686A),
                          Color(0xFF38686A),
                        ],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.decal),
                    borderRadius: BorderRadius.only(
                        bottomRight:
                            Radius.circular(AppDimens.MARGIN_CARD_MEDIUM_2),
                        bottomLeft:
                            Radius.circular(AppDimens.MARGIN_CARD_MEDIUM_2))),
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.MARGIN_MEDIUM_2,
                    vertical: AppDimens.MARGIN_MEDIUM_2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShowRoundedImageWidget(
                      imagePath: controller.shopProfileResponse?.image1! ?? "",
                      width: 80,
                      height: 80,
                    ),
                    const SizedBox(
                      width: AppDimens.MARGIN_MEDIUM,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextViewWidget(
                          controller.shopProfileResponse?.name ?? "",
                          textSize: AppDimens.TEXT_REGULAR_2X,
                          fontWeight: FontWeight.w700,
                          textColor: AppColors.whiteColor,
                        ),
                        const SizedBox(
                          height: AppDimens.MARGIN_EXTRA_SMALL,
                        ),
                        SizedBox(
                          width: Get.width * 0.7,
                          child: TextViewWidget(
                              controller.shopProfileResponse?.description ?? "",
                              fontWeight: FontWeight.normal,
                              textColor: AppColors.whiteColor),
                        ),
                        const SizedBox(
                          height: AppDimens.MARGIN_SMALL,
                        ),
                        // DecoratedBox(
                        //     decoration: const BoxDecoration(
                        //         color: AppColors.whiteColor,
                        //         borderRadius: BorderRadius.all(
                        //             Radius.circular(AppDimens
                        //                 .MARGIN_MEDIUM_2))),
                        //     child: Padding(
                        //       padding: const EdgeInsets.symmetric(
                        //           horizontal: 8.0, vertical: 2),
                        //       child: Wrap(
                        //         children: [
                        //           Icon(
                        //             Icons.location_on_rounded,
                        //             size: 18,
                        //             color: AppColors.shadeGrayColor,
                        //           ),
                        //           SizedBox(
                        //             width: AppDimens.MARGIN_SMALL,
                        //           ),
                        //           TextViewWidget(
                        //             controller.shopProfileResponse?.attractions??
                        //                 "",
                        //             textSize:
                        //             AppDimens.TEXT_HEADING_1X,
                        //             textOverflow: TextOverflow.ellipsis,
                        //             textColor:
                        //             AppColors.primaryColor,
                        //           ),
                        //         ],
                        //       ),
                        //     )),
                        // const SizedBox(
                        //   height: AppDimens.MARGIN_SMALL,
                        // ),
                        /*       DecoratedBox(
                          decoration: const BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(AppDimens
                                      .MARGIN_MEDIUM_2))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 2),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.lock_clock,
                                  size: 18,
                                  color: AppColors.shadeGrayColor,
                                ),
                                SizedBox(
                                  width: AppDimens.MARGIN_SMALL,
                                ),
                                TextViewWidget(
                                  "${controller.merchantProfileOb.value.openHour ?? ""} to ${controller.merchantProfileOb.value.closeHour ?? ""}",
                                  textSize:
                                  AppDimens.TEXT_HEADING_1X,
                                  textColor:
                                  AppColors.primaryColor,
                                ),
                              ],
                            ),
                          ))*/
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: AppDimens.MARGIN_SMALL,
        ),
        profileMenuItemWidget(
            title: "Account Information",
            color: AppColors.appBarColor,
            icon: const Icon(
              Icons.person,
              color: AppColors.whiteColor,
            ),
            onClick: () => Get.toNamed(Routes.profileDetail)),
        const SizedBox(
          height: AppDimens.MARGIN_MEDIUM,
        ),
        profileMenuItemWidget(
            title: "Change Password",
            color: AppColors.appBarColor,
            icon: const Icon(
              Icons.lock,
              color: AppColors.whiteColor,
            ),
            onClick: () => Get.toNamed(Routes.changePassword)),
        const SizedBox(
          height: AppDimens.MARGIN_MEDIUM,
        ),
        profileMenuItemWidget(
            title: "Contacts to Admin",
            color: AppColors.appBarColor,
            icon: const Icon(
              Icons.headset_mic_rounded,
              color: AppColors.whiteColor,
            ),
            onClick: () => AppUtils.showToast("call 09444977435")),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(AppDimens.MARGIN_CARD_MEDIUM),
          child: GestureDetector(
            onTap: () => context.showPromptDialog(
                title: "Logout",
                content: "Are you sure want to logout",
                okBtnFunction: () => controller.logout()),
            child: Material(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimens.MARGIN_MEDIUM_2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    TextViewWidget(
                      "Logout",
                      textColor: AppColors.primaryColor,
                    ),
                    SizedBox(
                      width: AppDimens.MARGIN_MEDIUM_2,
                    ),
                    Icon(
                      Icons.logout,
                      color: AppColors.primaryColor,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget profileMenuItemWidget(
      {required String title,
      required Color color,
      required Icon icon,
      required Function onClick}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GestureDetector(
        onTap: () => onClick(),
        child: Material(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.MARGIN_MEDIUM_2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                      color: color,
                      borderRadius: const BorderRadius.all(
                          Radius.circular(AppDimens.MARGIN_MEDIUM))),
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimens.MARGIN_SMALL),
                    child: Center(
                      child: icon,
                    ),
                  ),
                ),
                const SizedBox(
                  width: AppDimens.MARGIN_MEDIUM_2,
                ),
                TextViewWidget(
                  title,
                  textColor: AppColors.darkBlueColor,
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward,
                  color: AppColors.primaryColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

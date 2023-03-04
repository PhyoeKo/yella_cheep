import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/constant/resources/app_dimens.dart';
import 'package:explore_places/get_x/constant/routing/app_route.dart';
import 'package:explore_places/get_x/core/base/base_view.dart';
import 'package:explore_places/get_x/core/utils/app_utils.dart';
import 'package:explore_places/get_x/core/utils/dialog_utils.dart';
import 'package:explore_places/get_x/features/profile/controller/profile_controller.dart';
import 'package:explore_places/get_x/widget/default_app_bar_widget.dart';
import 'package:explore_places/get_x/widget/dialog/dialog_qr_view.dart';
import 'package:explore_places/get_x/widget/goLogin/go_login_widget.dart';
import 'package:explore_places/get_x/widget/show_image_widget.dart';
import 'package:explore_places/get_x/widget/text_view_widget.dart';
import 'package:explore_places/get_x/widget/widget_rounded_icon.dart';
import 'package:explore_places/utils/AppImages.dart';
import 'package:explore_places/utils/Extensions/SettingItemWidget.dart';
import 'package:explore_places/utils/Extensions/Widget_extensions.dart';
import 'package:explore_places/utils/Extensions/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/preferred_size.dart';
import 'package:get/get.dart';

class ProfileScreen extends BaseView<ProfileController> {
  ProfileScreen({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return DefaultAppBar(
      title: "More",
    );
  }

  @override
  Widget body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: Obx(() => controller.didLogin.value
              ? Stack(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                          minHeight: Get.height * 0.15,
                          minWidth: double.infinity,
                          maxHeight: 400),
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                AppColors.primaryColor,
                                AppColors.secondaryColor,
                              ],
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.decal),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(
                                  AppDimens.MARGIN_CARD_MEDIUM_2),
                              bottomLeft: Radius.circular(
                                  AppDimens.MARGIN_CARD_MEDIUM_2))),
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppDimens.MARGIN_MEDIUM_2,
                          vertical: AppDimens.MARGIN_MEDIUM_2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ShowRoundedImageWidget(
                            imagePath: controller.profileOb.value.image ?? "",
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
                                controller.profileOb.value.name ?? "",
                                textSize: AppDimens.TEXT_REGULAR_2X,
                                fontWeight: FontWeight.w700,
                                textColor: AppColors.whiteColor,
                              ),
                              const SizedBox(
                                height: AppDimens.MARGIN_EXTRA_SMALL,
                              ),
                              SizedBox(
                                child: TextViewWidget(
                                    controller.profileOb.value.phone ?? "",
                                    fontWeight: FontWeight.normal,
                                    textColor: AppColors.whiteColor),
                              ),
                              const SizedBox(
                                height: AppDimens.MARGIN_SMALL,
                              ),
                            ],
                          ),
                          RoundedIconWidget(
                              icon: Icon(
                                Icons.edit,
                                color: AppColors.whiteColor,
                              ),
                              onClickIcon: () =>
                                  Get.toNamed(Routes.profileEdit)),
                          Spacer(),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              RoundedIconWidget(
                                  icon: Icon(
                                    Icons.qr_code,
                                    color: AppColors.appBarColor,
                                  ),
                                  backgroundColor: AppColors.whiteColor,
                                  onClickIcon: () => showDialog(
                                        context: context,
                                        builder: (_) {
                                          return QrViewDialog(
                                            title:
                                                controller.profileOb.value.uuid,
                                          );
                                        },
                                      )),
                              TextViewWidget(
                                "Scan me",
                                textColor: AppColors.whiteColor,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 12.0,left: 12.0),
                  child: GoLoginWidget(
                      desc: "Login to find your exclusive activities",
                      title: "Your profile"),
                )),
        ),
        const SizedBox(
          height: AppDimens.MARGIN_CARD_MEDIUM,
        ),
        profileMenuItemWidget(
                title: "Invoice History",
                color: AppColors.appBarColor,
                icon: const Icon(
                  Icons.inventory_outlined,
                  color: AppColors.whiteColor,
                ),
                onClick: () => Get.toNamed(Routes.orderHistory))
            .visible(controller.didLogin.value),
        const SizedBox(
          height: AppDimens.MARGIN_MEDIUM,
        ),
        profileMenuItemWidget(
            title: "App Language",
            color: AppColors.appBarColor,
            icon: const Icon(
              Icons.language,
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
        const SizedBox(
          height: AppDimens.MARGIN_MEDIUM,
        ),
        profileMenuItemWidget(
            title: "About us",
            color: AppColors.appBarColor,
            icon: const Icon(
              Icons.info_sharp,
              color: AppColors.whiteColor,
            ),
            onClick: () => AppUtils.showToast("call 09444977435")),
        const Spacer(),
        Obx(() => controller.didLogin.value
            ? Padding(
                padding: const EdgeInsets.all(AppDimens.MARGIN_CARD_MEDIUM),
                child: GestureDetector(
                  onTap: () => context.showPromptDialog(
                      title: "Logout",
                      content: "Are you sure want to logout",
                      okBtnFunction: () => controller.logout()),
                  child: Material(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppDimens.MARGIN_MEDIUM_2),
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
              )
            : SizedBox())
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

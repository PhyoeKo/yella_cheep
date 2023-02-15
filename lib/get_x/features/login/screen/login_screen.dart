import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yella_merchant/constant/resources/app_colors.dart';
import 'package:yella_merchant/constant/resources/app_dimens.dart';
import 'package:yella_merchant/constant/resources/app_images.dart';
import 'package:yella_merchant/core/base/base_view.dart';
import 'package:yella_merchant/features/login/controller/login_controller.dart';
import 'package:yella_merchant/widget/primary_button_widget.dart';
import 'package:yella_merchant/widget/text_view_widget.dart';

class LoginScreen extends BaseView<LoginController> {
  LoginScreen({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Color pageBackgroundColor() {
    return AppColors.appBarColor;
  }

  @override
  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: Get.height * 0.2,
          ),
          Image.asset(
            AppImages.appLogo,
            width: Get.height * 0.15,
            height: Get.height * 0.15,
          ),
          const Center(
            child: TextViewWidget(
              "Yella Merchant Login",
              textSize: 18,
              fontWeight: FontWeight.w700,
              textColor: AppColors.whiteColor,
            ),
          ),
          const SizedBox(
            height: AppDimens.MARGIN_LARGE,
          ),
          TextField(
            controller: controller.userNameController,
            autofocus: false,
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
              hintText: "Enter username",
              contentPadding: const EdgeInsets.all(
                AppDimens.MARGIN_CARD_MEDIUM_2,
              ),
              fillColor: AppColors.spaceWhiteColor,
              prefixIcon: Icon(Icons.person),
            ),
          ),
          const SizedBox(
            height: AppDimens.MARGIN_CARD_MEDIUM_2,
          ),
          Obx(() => TextField(
                autofocus: false,
                obscureText: !controller.showPassword.value,
                controller: controller.passwordController,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppDimens.MARGIN_MEDIUM),
                    ),
                    borderSide: BorderSide(color: AppColors.spaceWhiteColor),
                  ),
                  enabledBorder: const OutlineInputBorder(
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
                  hintText: "Password",
                  isDense: true,
                  contentPadding: const EdgeInsets.all(
                    AppDimens.MARGIN_CARD_MEDIUM_2,
                  ),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: controller.showPassword.value
                        ? Icon(
                            Icons.visibility,
                            color: AppColors.textColor.withOpacity(
                              0.6,
                            ),
                          )
                        : Icon(
                            Icons.visibility_off,
                            color: AppColors.textColor.withOpacity(
                              0.6,
                            ),
                          ),
                    onPressed: () => controller.showHidePassword(),
                  ),
                  fillColor: AppColors.spaceWhiteColor,
                ),
              )),
          const SizedBox(
            height: AppDimens.MARGIN_CARD_MEDIUM_2,
          ),
          PrimaryButton(
            "Login",
            () => controller.doLogin(),
          )
        ],
      ),
    );
  }
}

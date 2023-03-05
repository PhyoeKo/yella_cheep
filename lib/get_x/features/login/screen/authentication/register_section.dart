import 'package:explore_places/get_x/constant/resources/app_dimens.dart';
import 'package:explore_places/get_x/constant/resources/app_images.dart';
import 'package:explore_places/get_x/constant/resources/app_string.dart';
import 'package:explore_places/get_x/features/login/controller/login_controller.dart';
import 'package:explore_places/get_x/widget/based_designed_card.dart';
import 'package:explore_places/get_x/widget/custom_text_field.dart';
import 'package:explore_places/get_x/widget/text_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constant/resources/app_colors.dart';
import '../../../../widget/custom_password_field.dart';

class RegisterOrLoginSection extends StatelessWidget {
  final AnimationController animationController;
  final TextEditingController nickNameController;
  final TextEditingController phNoController;
  final TextEditingController passwordController;
  final LoginController controller;

  RegisterOrLoginSection({
    Key? key,
    required this.animationController,
    required this.nickNameController,
    required this.phNoController,
    required this.passwordController,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _enterAnimation =
        Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    final _exitAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-1, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    return SlideTransition(
      position: _enterAnimation,
      child: SlideTransition(
        position: _exitAnimation,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                AppImages.appLogo,
                width: 150,
                height: 150,
              ),
            ),
            SizedBox(
              height: AppDimens.MARGIN_MEDIUM,
            ),
            SizedBox(
              width: double.infinity,
              child: Center(
                child: TextViewWidget(
                  AppString.welcomeFromYella.tr,
                  textColor: Colors.white,
                  fontWeight: FontWeight.bold,
                  textSize: AppDimens.TEXT_HEADING_1X,
                ),
              ),
            ),
            const SizedBox(height: AppDimens.MARGIN_LARGE),
            Obx(() => BasedDesignedCard(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextViewWidget(
                        controller.isRegisteredAccount.value
                            ? AppString.phoneNumber.tr
                            : AppString.userName.tr,
                        textColor: AppColors.primaryColor,
                      ),
                      const SizedBox(height: AppDimens.MARGIN_CARD_MEDIUM),
                      CustomTextField(
                        controller: controller.isRegisteredAccount.value
                            ? phNoController
                            : nickNameController,
                        onChanged: (value) {},
                        isEnabled: !controller.isRegisteredAccount.value,
                        hint: controller.isRegisteredAccount.value
                            ? AppString.enterPhoneNumber.tr
                            : AppString.enterUserName.tr,
                      ),
                      const SizedBox(height: AppDimens.MARGIN_CARD_MEDIUM_2),
                      TextViewWidget(
                        AppString.password.tr,
                        textColor: AppColors.primaryColor,
                      ),
                      const SizedBox(height: AppDimens.MARGIN_CARD_MEDIUM),
                      CustomPasswordField(
                        controller: passwordController,
                        onChanged: (value) {},
                        hint: AppString.enterPassword.tr,
                      ),
                      const SizedBox(height: AppDimens.MARGIN_MEDIUM),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

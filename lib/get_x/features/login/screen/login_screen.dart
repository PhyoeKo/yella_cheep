import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/constant/resources/app_dimens.dart';
import 'package:explore_places/get_x/constant/resources/app_string.dart';
import 'package:explore_places/get_x/core/base/base_view.dart';
import 'package:explore_places/get_x/features/login/controller/login_controller.dart';
import 'package:explore_places/get_x/features/login/screen/authentication/button_section.dart';
import 'package:explore_places/get_x/features/login/screen/authentication/otp_verify_section.dart';
import 'package:explore_places/get_x/features/login/screen/authentication/register_section.dart';
import 'package:explore_places/get_x/features/login/screen/authentication/request_otp_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    return WillPopScope(
      onWillPop: () async {
        controller.onScreenExit();
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            // const GradientBackground(),
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding:
                        const EdgeInsets.only(top: AppDimens.MARGIN_MEDIUM),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: AppDimens.MARGIN_MEDIUM_3),
                        GetBuilder(
                          init: controller,
                          builder: (_) => Column(
                            children: [
                              Stack(
                                children: [
                                  RequestOTPSection(
                                    loginPhNoController:
                                        controller.phNoController,
                                    animationController:
                                        controller.animationController,
                                    loginController: controller,
                                    onPressLogin: () =>
                                        controller.requestOtp(context),
                                  ),
                                  OTPVerifySection(
                                    phNo: controller.phNoController.text,
                                    pinController:
                                        controller.referCodeController,
                                    animationController:
                                        controller.animationController,
                                    isRegisteredAccount:
                                        controller.isRegisteredAccount.value,
                                    loginController: controller,
                                  ),
                                  RegisterOrLoginSection(
                                    nickNameController:
                                        controller.registerNickNameController,
                                    phNoController: controller.phNoController,
                                    passwordController:
                                        controller.loginPasswordController,
                                    animationController:
                                        controller.animationController,
                                    controller: controller,
                                  ),
                                ],
                              ),
                              AuthButtonSection(
                                btnText: controller.isRegisteredAccount.value
                                    ? AppString.login.tr
                                    : AppString.register.tr,
                                animationController:
                                    controller.animationController,
                                onPressed: () {
                                  controller.onNext();
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

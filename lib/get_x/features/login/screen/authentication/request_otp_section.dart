import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/constant/resources/app_dimens.dart';
import 'package:explore_places/get_x/constant/resources/app_images.dart';
import 'package:explore_places/get_x/constant/resources/app_string.dart';
import 'package:explore_places/get_x/features/login/controller/login_controller.dart';
import 'package:explore_places/get_x/widget/based_designed_card.dart';
import 'package:explore_places/get_x/widget/custom_text_field.dart';
import 'package:explore_places/get_x/widget/text_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RequestOTPSection extends StatelessWidget {
  final AnimationController animationController;
  final TextEditingController loginPhNoController;
  final Function onPressLogin;
  final LoginController loginController;

  RequestOTPSection({
    Key? key,
    required this.animationController,
    required this.onPressLogin,
    required this.loginPhNoController,
    required this.loginController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _enterAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.0,
        0.2,
        curve: Curves.elasticInOut,
      ),
    ));

    final _exitAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, -2))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.2,
        0.4,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    return SlideTransition(
      position: _exitAnimation,
      child: Column(
        children: [

          ScaleTransition(
            scale: _enterAnimation,
            child: SizedBox(
              width: double.infinity,
              child: Image.asset(
                AppImages.appLogo,
                width: 150,
                height: 150,
              ),
            ),
          ),
          SizedBox(
            height: AppDimens.MARGIN_MEDIUM,
          ),
          ScaleTransition(
            scale: _enterAnimation,
            child: SizedBox(
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
          ),
          const SizedBox(height: AppDimens.MARGIN_LARGE),
          BasedDesignedCard(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextViewWidget(
                  AppString.enterPhoneNumber.tr,
                  textSize: AppDimens.TEXT_REGULAR_2X,
                  fontWeight: FontWeight.w600,
                  textColor: AppColors.primaryColor,
                ),
                const SizedBox(height: AppDimens.MARGIN_MEDIUM),
                TextViewWidget(
                  AppString.sendOTPCode.tr,
                  textSize: AppDimens.TEXT_REGULAR,
                  fontWeight: FontWeight.w400,
                ),
                const SizedBox(height: AppDimens.MARGIN_CARD_MEDIUM_2),
                CustomTextField(
                    controller: loginPhNoController,
                    onChanged: (value) {},
                    hint: AppString.phoneNumber.tr,
                    textInputType: TextInputType.number,
                    textInputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                    ]),
                const SizedBox(height: AppDimens.MARGIN_CARD_MEDIUM_2),
              ],
            ),
          ),
          const SizedBox(height: AppDimens.MARGIN_LARGE),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.MARGIN_CARD_MEDIUM_2),
            child: ScaleTransition(
              scale: _enterAnimation,
              child: LoginButton(onPressed: () => onPressLogin()),
            ),
          )
        ],
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      elevation: 0,
      height: 52,
      onPressed: () {
        onPressed();
      },
      color: Colors.white,
      splashColor: AppColors.appBarColor.withOpacity(0.1),
      shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(AppDimens.MARGIN_MEDIUM))),
      child: Center(
        child: TextViewWidget(
          AppString.requestOTP.tr,
          textColor: AppColors.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/constant/resources/app_dimens.dart';
import 'package:explore_places/get_x/constant/resources/app_images.dart';
import 'package:explore_places/get_x/constant/resources/app_string.dart';
import 'package:explore_places/get_x/features/login/controller/login_controller.dart';
import 'package:explore_places/get_x/widget/based_designed_card.dart';
import 'package:explore_places/get_x/widget/text_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPVerifySection extends StatefulWidget {
  final AnimationController animationController;
  final LoginController loginController;
  final TextEditingController pinController;
  final String phNo;
  final bool isRegisteredAccount;

  const OTPVerifySection({
    Key? key,
    required this.animationController,
    required this.loginController,
    required this.pinController,
    required this.phNo,
    this.isRegisteredAccount = true,
  }) : super(key: key);

  @override
  State<OTPVerifySection> createState() => _OTPVerifySectionState();
}

class _OTPVerifySectionState extends State<OTPVerifySection> {
  late StreamController<ErrorAnimationType> errorController;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _enterAnimation =
        Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
            .animate(CurvedAnimation(
      parent: widget.animationController,
      curve: const Interval(
        0.2,
        0.4,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    final _exitAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-1, 0))
            .animate(CurvedAnimation(
      parent: widget.animationController,
      curve: const Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    final _enterScaleAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: widget.animationController,
      curve: const Interval(
        0.0,
        0.2,
        curve: Curves.elasticInOut,
      ),
    ));
    return SlideTransition(
      position: _enterAnimation,
      child: SlideTransition(
        position: _exitAnimation,
        child: Column(
          children: [
            ScaleTransition(
              scale: _enterScaleAnimation,
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
              scale: _enterScaleAnimation,
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: TextViewWidget(
                    AppString.welcomeFromYella.tr,
                    textColor: Colors.black45,
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
                    AppString.otpVerification.tr,
                    textSize: AppDimens.TEXT_REGULAR,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: AppDimens.MARGIN_MEDIUM),
                  TextViewWidget(
                    AppString.sendOTPCode.trParams({'phNo': widget.phNo}),
                    textSize: AppDimens.TEXT_REGULAR,
                    fontWeight: FontWeight.w400,
                  ),
                  const SizedBox(height: AppDimens.MARGIN_MEDIUM_2),
                  PinCodeTextField(
                    autoDismissKeyboard: false,
                    appContext: context,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderWidth: 0.3,
                      borderRadius:
                          BorderRadius.circular(AppDimens.MARGIN_MEDIUM),
                      fieldHeight: MediaQuery.of(context).size.width * 0.11,
                      fieldWidth: MediaQuery.of(context).size.width * 0.11,
                      activeColor: AppColors.brownRedColor,
                      activeFillColor: Colors.white10,
                      inactiveColor: AppColors.brownRedColor,
                      inactiveFillColor: Colors.white,
                      selectedColor: AppColors.appBarColor,
                      selectedFillColor: Colors.white,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    animationDuration: const Duration(milliseconds: 100),
                    enableActiveFill: true,
                    errorAnimationController: errorController,
                    controller: widget.pinController,
                    onCompleted: (value) => print("Complete"),
                    onChanged: (value) {
                      print(value);
                    },
                    onSubmitted: (value) => {},
                  ),
                  const SizedBox(height: AppDimens.MARGIN_MEDIUM),
                  // GestureDetector(
                  //   onTap: () => widget.animationController.animateTo(0.2),
                  //   child: Align(
                  //     alignment: Alignment.centerRight,
                  //     child: TextViewWidget("Edit phone number?",
                  //         textDecoration: TextDecoration.underline,
                  //         textColor: AppColors.primaryColor,
                  //         fontWeight: FontWeight.w300),
                  //   ),
                  // ),

                  const SizedBox(height: AppDimens.MARGIN_MEDIUM),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            widget.loginController.isRegisteredAccount.value =
                                false;
                            widget.animationController.animateTo(0.6);
                            widget.loginController.update();
                          },
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextViewWidget(AppString.signUp.tr,
                                textDecoration: TextDecoration.underline,
                                textColor: AppColors.primaryColor,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () =>
                              widget.animationController.animateTo(0.2),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextViewWidget(AppString.editPhNo.tr,
                                textDecoration: TextDecoration.underline,
                                textColor: AppColors.primaryColor,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDimens.MARGIN_MEDIUM),
                ],
              ),
            ),
            const SizedBox(
              height: AppDimens.MARGIN_MEDIUM,
            ),
            !widget.isRegisteredAccount
                ? GestureDetector(
                    onTap: () async => {
                      FocusScope.of(context).requestFocus(new FocusNode()),
                      await Future.delayed(const Duration(milliseconds: 500)),
                      widget.animationController.animateTo(0.6),
                    },
                    child: TextViewWidget(
                      AppString.tryWithPassword.tr,
                      textColor: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class RegisterText extends StatelessWidget {
  const RegisterText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        TextSpan(
            text: AppString.editPhone.tr,
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: AppColors.primaryColor,
              fontFamily: 'Poppins',
            ))
      ]),
    );
  }
}

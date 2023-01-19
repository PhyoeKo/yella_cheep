import 'dart:async';

import 'package:explore_places/main.dart';
import 'package:explore_places/services/PhoneAuthService.dart';
import 'package:explore_places/utils/AppColor.dart';
import 'package:explore_places/utils/AppImages.dart';
import 'package:explore_places/utils/Common.dart';
import 'package:explore_places/utils/Extensions/AppButton.dart';
import 'package:explore_places/utils/Extensions/AppTextField.dart';
import 'package:explore_places/utils/Extensions/Commons.dart';
import 'package:explore_places/utils/Extensions/Constants.dart';
import 'package:explore_places/utils/Extensions/Widget_extensions.dart';
import 'package:explore_places/utils/Extensions/context_extensions.dart';
import 'package:explore_places/utils/Extensions/decorations.dart';
import 'package:explore_places/utils/Extensions/int_extensions.dart';
import 'package:explore_places/utils/Extensions/text_styles.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class LoginScreen extends StatefulWidget {
  static String tag = '/LoginScreen';

  LoginScreen({Key? key}) : super(key: key);

  @override
  _PhoneAuthPageState createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<LoginScreen> {
  int start = 60;
  bool wait = false;
  String buttonName = language.send;
  final TextEditingController phoneController = TextEditingController();
  AuthClass authClass = AuthClass();
  String verificationIdFinal = "";
  String smsCode = "";
  String countryCode = "+971";
  final countryPicker = const FlCountryCodePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkMode ? scaffoldColorDark : primaryColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(language.signIn),
        backgroundColor: appStore.isDarkMode ? scaffoldColorDark : primaryColor,
        titleTextStyle: boldTextStyle(color: Colors.white, size: 20),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                16.height,
                Image.asset(login_logo_image, width: 100, height: 100),
                16.height,
                Text(language.signInText,
                    style: primaryTextStyle(color: Colors.white, size: 18),
                    textAlign: TextAlign.center),
                30.height,
                textField(),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 30,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                      Text(
                        language.enterOTP,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                otpField(),
                SizedBox(
                  height: 40,
                ),
                RichText(
                    text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Send OTP again in ",
                      style:
                          TextStyle(fontSize: 16, color: Colors.yellowAccent),
                    ),
                    TextSpan(
                      text: "00:$start",
                      style: TextStyle(fontSize: 16, color: Colors.pinkAccent),
                    ),
                    TextSpan(
                      text: " sec ",
                      style:
                          TextStyle(fontSize: 16, color: Colors.yellowAccent),
                    ),
                  ],
                )),
                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppButtonWidget(
                    text: language.signIn,
                    textStyle: boldTextStyle(color: primaryColor),
                    shapeBorder: RoundedRectangleBorder(
                        borderRadius: radius(defaultRadius)),
                    color: Colors.yellowAccent,
                    onTap: () {
                      appStore.setLoading(true);
                      // showLoadingDialog(context: context);
                      authClass
                          .signInwithPhoneNumber(
                              verificationIdFinal, smsCode, context)
                          .then((value) {
                        appStore.setLoading(false);
                        finish(context, true);
                      });
                    },
                    width: context.width(),
                  ),
                ),
              ],
            ),
          ),
          Observer(
              builder: (context) => loaderWidget().visible(appStore.isLoading)),
        ],
      ),
    );
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  Widget otpField() {
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width - 34,
      fieldWidth: 58,
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: Color(0xffFAFAFA),
        borderColor: Colors.white,
      ),
      style: TextStyle(fontSize: 17, color: Colors.black54),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.box,
      onCompleted: (pin) {
        print("Completed: " + pin);
        setState(() {
          smsCode = pin;
        });
      },
    );
  }

  Widget textField() {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 60,
      decoration: BoxDecoration(
        color: Color(0xffFAFAFAFA),
        borderRadius: BorderRadius.circular(15),
      ),
      child: AppTextField(
        controller: phoneController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Enter phone number",
          hintStyle: TextStyle(color: Colors.black54, fontSize: 14),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
            child: InkWell(
              onTap: () async {
                final code = await countryPicker.showPicker(context: context);
                if (code != null) {
                  print(code);
                  setState(() {
                    countryCode = code.dialCode;
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Text(
                  "($countryCode)",
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          suffixIcon: InkWell(
            onTap: wait
                ? null
                : () async {
                    hideKeyboard(context);
                    setState(() {
                      start = 60;
                      wait = true;
                      buttonName = language.resend;
                    });
                    await authClass.verifyPhoneNumber(
                        "$countryCode${phoneController.text}",
                        context,
                        setData);
                    //  print("Phone Number is +95 ${phoneController.text}");
                  },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Text(
                buttonName,
                style: TextStyle(
                  color: wait ? Colors.grey : Colors.black54,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        textFieldType: TextFieldType.PHONE,
      ),
    );
  }

  void setData(String verificationId) {
    setState(() {
      verificationIdFinal = verificationId;
    });
    startTimer();
  }
}

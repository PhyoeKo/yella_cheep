import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:explore_places/get_x/constant/routing/app_route.dart';
import 'package:explore_places/get_x/core/base/base_controller.dart';
import 'package:explore_places/get_x/core/utils/app_utils.dart';
import 'package:explore_places/get_x/data_models/base_response/base_api_response.dart';
import 'package:explore_places/get_x/data_models/request_ob/login_request_ob.dart';
import 'package:explore_places/get_x/data_models/request_ob/register_request_ob.dart';
import 'package:explore_places/get_x/data_models/responses/profile/profile_response.dart';
import 'package:explore_places/get_x/data_sources/local/cache_manager.dart';
import 'package:explore_places/get_x/data_sources/network/authentication/auth_repository.dart';
import 'package:explore_places/get_x/features/sample_feature/mapper/sample_mapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  final AuthRepository _repository = Get.find(tag: (AuthRepository).toString());

  late AnimationController animationController;
  final referCodeController = TextEditingController();
  final phNoController = TextEditingController();
  final registerNickNameController = TextEditingController();
  final loginPasswordController = TextEditingController();
  RxBool isRegisteredAccount = true.obs;

  @override
  void onInit() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    animationController.animateTo(0.0);
    animationController.animateTo(0.2);
    super.onInit();
  }

  Future<void> requestOtp(BuildContext context) async {
    if (phNoController.text == "") {
      AppUtils.showToast("Invalid phone number");
      return;
    }
    FocusScope.of(context).requestFocus(new FocusNode());
    await Future.delayed(const Duration(milliseconds: 500));
    animationController.animateTo(0.4);
    update();
    //print("Firebase Token is ${getString(CacheManagerKey.firebaseToken)}");
    // var requestOb = LoginRequestOb(
    //   phone: phNoController.text,
    //   password: "",
    // );
    // final repoService = _repository.loginUser(requestOb);
    // AppUtils.showLoaderDialog();
    // callAPIService(repoService, onSuccess: onSuccessLogin,
    //     onError: (exception) {
    //   AppUtils.showToast("Something went wrong,try again");
    //   Get.back();
    // });
    // try {
    //   var otpRequest = SentOtpRequest(type: "register", phone: phNo);
    //   BaseModel<SentOtpResponse> response =
    //   await _repository.sentOtp(otpRequest);
    //
    //   if (response.result != null) {
    //     if (response.result!.status == true) {
    //       _isRegisteredAccount = response.result!.data!.isRegister;
    //       FocusScope.of(context).requestFocus(new FocusNode());
    //       await Future.delayed(const Duration(milliseconds: 500));
    //       animationController.animateTo(0.4);
    //       notifyListeners();
    //     } else {
    //       setNotifyMessage(response.result?.error?[0] ?? "Fail to sent OTP");
    //     }
    //   } else {
    //     setNotifyMessage(response.exception?.errorMessage??"Something went wrong");
    //   }
    // } catch (_) {
    //   setNotifyMessage("$_");
    // }

    // Get.back();
  }

  Future<void> checkOtp(BuildContext context) async {
    AppUtils.showToast("Logging in..");
    FocusScope.of(context).requestFocus(new FocusNode());
    animationController.animateTo(0.6);
    update();
    // try {
    //   FocusScope.of(context).requestFocus(new FocusNode());
    //
    //   var otpRequest = CheckOtpRequest(code: otpCode, phone: phNo);
    //   BaseModel<LoginResponse> response =
    //   await _repository.checkOTP(otpRequest);
    //
    //   if (response.result != null) {
    //     Navigator.pop(context);
    //     if (response.result!.status == true) {
    //       if (_isRegisteredAccount == true) {
    //         saveUserData(
    //           response.result!.data!.token!,
    //           response.result!.data!.name!,
    //           response.result!.data!.phone!,
    //           response.result!.data!.address!,
    //         );
    //         Navigator.pop(context, true);
    //         _repository.updateFirebaseToken(token: firebaseMessagingToken);
    //       } else {
    //         animationController.animateTo(0.6);
    //       }
    //     } else {
    //       print("${response.result!.message}");
    //       setNotifyMessage("Something went wrong");
    //     }
    //   } else {
    //     setNotifyMessage(response.exception?.errorMessage??"Something went wrong");
    //   }
    // } catch (_) {
    //   print("$_");
    //   setNotifyMessage("$_");
    // }
  }

  Future<void> register(BuildContext context) async {
    AppUtils.showToast("Registering ...");
    FocusScope.of(context).requestFocus(new FocusNode());
    update();
    // try {
    //   FocusScope.of(context).requestFocus(new FocusNode());
    //
    //   var otpRequest =
    //   RegisterRequest(name: name, phone: phNo, password: password);
    //   BaseModel<RegisterResponse> response =
    //   await _repository.register(otpRequest);
    //
    //   if (response.result != null) {
    //     Navigator.pop(context);
    //     if (response.result!.status == true) {
    //       saveUserData(
    //         response.result!.data!.token!,
    //         response.result!.data!.name!,
    //         response.result!.data!.phone!,
    //         response.result!.data!.address!,
    //       );
    //       Navigator.pop(context, true);
    //
    //       _repository.updateFirebaseToken(token: firebaseMessagingToken);
    //     } else {
    //       setNotifyMessage(response.result!.message ?? "Something went wrong");
    //     }
    //   } else {
    //     setNotifyMessage(response.exception?.errorMessage??"Something went wrong");
    //   }
    // } catch (_) {
    //   setNotifyMessage("$_");
    //   Navigator.pop(context);
    // }
    var requestOb = RegisterRequestOb(
      phone: phNoController.text,
      password: loginPasswordController.text,
      name: registerNickNameController.text,
      email: "",
    );
    final repoService = _repository.registerUser(requestOb);
    AppUtils.showLoaderDialog();
    callAPIService(repoService, onSuccess: onSuccessLogin,
        onError: (exception) {
          AppUtils.showToast("Something went wrong,try again");
          Get.back();
        });
  }

  Future<void> login() async {
    AppUtils.showToast("Logging in ...");
    update();
    var requestOb = LoginRequestOb(
      phone: phNoController.text,
      password: loginPasswordController.text,
    );
    final repoService = _repository.loginUser(requestOb);
    AppUtils.showLoaderDialog();
    callAPIService(repoService, onSuccess: onSuccessLogin,
        onError: (exception) {
      AppUtils.showToast("Something went wrong,try again");
      Get.back();
    });
    // try {
    //   LoginRequest loginRequest = LoginRequest(phone: phNo, password: password);
    //
    //   BaseModel<LoginResponse> response = await _repository.login(loginRequest);
    //
    //   if (response.result != null) {
    //     Navigator.pop(context);
    //     if (response.result!.status == true) {
    //       saveUserData(
    //         response.result!.data!.token!,
    //         response.result!.data!.name!,
    //         response.result!.data!.phone!,
    //         response.result!.data!.address!,
    //       );
    //       Navigator.pop(context, true);
    //       _repository.updateFirebaseToken(token: firebaseMessagingToken);
    //     } else {
    //       setNotifyMessage(response.result!.message!);
    //     }
    //   } else {
    //     Navigator.pop(context);
    //     setNotifyMessage(response.exception?.errorMessage??"Something went wrong");
    //   }
    // } catch (_) {
    //   setNotifyMessage("$_");
    // }
  }

  void onSuccessLogin(response) {
    if (response != null) {
      BaseApiResponse<ProfileResponse> loginData = response;
      if (loginData.statusCode!) {
        ProfileResponse? loginResponse = loginData.objectResult;
        savingData(loginResponse!);
        Get.offAllNamed(Routes.mainHomeScreen);
      } else {
        AppUtils.showToast(loginData.message ?? "Invalid credentials");
        Get.back();
      }
    } else {
      AppUtils.showToast("Something went wrong. Try again!");
      Get.back();
    }
  } //

  void savingData(ProfileResponse loginResponse) {
    setData(CacheManagerKey.loginResponseData, jsonEncode(loginResponse));
  }

  onNext() {
    if (animationController.value >= 0.0 && animationController.value < 0.4) {
      animationController.animateTo(0.4);
    } else if (animationController.value >= 0.4 &&
        animationController.value < 0.6) {
      checkOtp(Get.context!);
    } else if (animationController.value >= 0.6 &&
        animationController.value < 0.8) {
      if (isRegisteredAccount.value) {
        login();
      } else {
        register(Get.context!);
      }
    }
    update();
  }

  onScreenExit() {
    if (animationController.value >= 0.4 && animationController.value < 0.6) {
      animationController.animateTo(0.2);
    } else if (animationController.value >= 0.6 &&
        animationController.value < 0.8) {
      animationController.animateTo(0.4);
    } else {
      // if (_sharedPreference.getString(prefAuthToken) == "") {
      //   Navigator.pop(context, false);
      // } else {
      //   Navigator.pop(context, true);
      // }
    }
    update();
  }

// void doLogin() {
//   //print("Firebase Token is ${getString(CacheManagerKey.firebaseToken)}");
//   var requestOb = LoginRequestOb(
//     phone: userNameController.text,
//     password: passwordController.text,
//   );
//   final repoService = _repository.loginUser(requestOb);
//   AppUtils.showLoaderDialog();
//   callAPIService(repoService, onSuccess: onSuccessLogin,
//       onError: (exception) {
//     AppUtils.showToast("Something went wrong,try again");
//     Get.back();
//   });
// }

// void onSuccessLogin(response) {
//   print("response is $response");
//   if (response != null) {
//     BaseApiResponse<LoginResponse> loginData = response;
//
//     if (loginData.statusCode!) {
//       LoginResponse? loginResponse = loginData.objectResult;
//       savingData(loginResponse!);
//       //updateFirebaseToken();
//       Get.offAllNamed(Routes.mainHomeScreen);
//     } else {
//
//       AppUtils.showToast(loginData.message ?? "Invalid credentials");
//       Get.back();
//     }
//   } else {
//     AppUtils.showToast("Something went wrong. Try again!");
//     Get.back();
//   }
// } //
}

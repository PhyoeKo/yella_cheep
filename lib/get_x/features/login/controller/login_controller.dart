import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:explore_places/get_x/constant/resources/app_string.dart';
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
      AppUtils.showToast(AppString.invalidNumber.tr);
      return;
    }
    FocusScope.of(context).requestFocus(new FocusNode());
    await Future.delayed(const Duration(milliseconds: 500));
    animationController.animateTo(0.4);
    update();
  }

  Future<void> checkOtp(BuildContext context) async {
    AppUtils.showToast(AppString.loggingIn.tr);
    FocusScope.of(context).requestFocus(new FocusNode());
    animationController.animateTo(0.6);
    update();
  }

  Future<void> register(BuildContext context) async {
    AppUtils.showToast(AppString.registering);
    FocusScope.of(context).requestFocus(new FocusNode());
    update();
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
      AppUtils.showToast(AppString.somethingWrong.tr);
      Get.back();
    });
  }

  Future<void> login() async {
    AppUtils.showToast(AppString.loggingIn.tr);
    update();
    var requestOb = LoginRequestOb(
      phone: phNoController.text,
      password: loginPasswordController.text,
    );
    final repoService = _repository.loginUser(requestOb);
    AppUtils.showLoaderDialog();
    callAPIService(repoService, onSuccess: onSuccessLogin,
        onError: (exception) {
      AppUtils.showToast(AppString.somethingWrong.tr);
      Get.back();
    });
  }

  void onSuccessLogin(response) {
    if (response != null) {
      BaseApiResponse<ProfileResponse> loginData = response;
      if (loginData.statusCode!) {
        ProfileResponse? loginResponse = loginData.objectResult;
        savingData(loginResponse!);
        Get.offAllNamed(Routes.mainHomeScreen);
      } else {
        AppUtils.showToast(loginData.message ?? AppString.invalidCredential.tr);
        Get.back();
      }
    } else {
      AppUtils.showToast(AppString.somethingWrong.tr);
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
}

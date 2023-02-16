import 'dart:convert';

import 'package:explore_places/get_x/constant/routing/app_route.dart';
import 'package:explore_places/get_x/core/base/base_controller.dart';
import 'package:explore_places/get_x/core/utils/app_utils.dart';
import 'package:explore_places/get_x/data_models/base_response/base_api_response.dart';
import 'package:explore_places/get_x/data_models/request_ob/login_request_ob.dart';
import 'package:explore_places/get_x/data_models/responses/login_response.dart';
import 'package:explore_places/get_x/data_sources/local/cache_manager.dart';
import 'package:explore_places/get_x/data_sources/network/authentication/auth_repository.dart';
import 'package:explore_places/get_x/features/sample_feature/mapper/sample_mapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginController extends BaseController {
  final AuthRepository _repository = Get.find(tag: (AuthRepository).toString());

  RxList<SampleVO> dummies = RxList.empty();

  late AnimationController _iconAnimationController;
  late Animation<double> iconAnimation;

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var showPassword = false.obs;

  @override
  void onInit() {
    _iconAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    iconAnimation = CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.easeOut,
    );
    //  _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
    super.onInit();
  }

  void showHidePassword() {
    showPassword.value = !showPassword.value;
  }

  void doLogin() {
    //print("Firebase Token is ${getString(CacheManagerKey.firebaseToken)}");
    var requestOb = LoginRequestOb(
      phone: userNameController.text,
      password: passwordController.text,
    );
    final repoService = _repository.loginUser(requestOb);
    AppUtils.showLoaderDialog();
    callAPIService(repoService, onSuccess: onSuccessLogin,
        onError: (exception) {
      AppUtils.showToast("Something went wrong,try again");
      Get.back();
    });
  }

  void onSuccessLogin(response) {
    print("response is $response");
    if (response != null) {
      BaseApiResponse<LoginResponse> loginData = response;

      if (loginData.statusCode!) {
        LoginResponse? loginResponse = loginData.objectResult;
        savingData(loginResponse!);
        //updateFirebaseToken();
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

  void savingData(LoginResponse loginResponse) {
    setData(CacheManagerKey.loginResponseData, jsonEncode(loginResponse));
  }
}

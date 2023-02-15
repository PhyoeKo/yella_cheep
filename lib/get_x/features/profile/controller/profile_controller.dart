import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yella_merchant/constant/enum/enum_image_type.dart';
import 'package:yella_merchant/constant/routing/app_route.dart';
import 'package:yella_merchant/core/base/base_controller.dart';
import 'package:yella_merchant/core/utils/app_utils.dart';
import 'package:yella_merchant/data_models/base_response/base_api_response.dart';
import 'package:yella_merchant/data_models/request_ob/custom_image_phaser_ob.dart';
import 'package:yella_merchant/data_models/request_ob/profile_update_request_ob.dart';

import 'package:yella_merchant/data_models/responses/merchant_profile_response.dart';
import 'package:yella_merchant/data_models/responses/shop_profile_response.dart';
import 'package:yella_merchant/data_sources/network/profile/profile_repository.dart';

class ProfileController extends BaseController {
  final ProfileRepository _repository =
      Get.find(tag: (ProfileRepository).toString());

  ShopProfileResponse? shopProfileResponse;

  var merchantProfileOb = MerchantProfileResponse().obs;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Rx<CustomImagePhaserOb?> profileImage = CustomImagePhaserOb().obs;
  Rx<String> image = "".obs;


  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchMerchantProfile();
    shopProfileResponse = getShopProfile();
  }

  void fetchMerchantProfile() async {
    final repoService = _repository.getMerchantProfile();

    await callAPIService(
      repoService,
      onSuccess: _handleResponseSuccess,
      onError: _handleResponseError,
    );
  }

  void _handleResponseSuccess(response) async {
    if (response != null) {
      BaseApiResponse<MerchantProfileResponse?> _merchantProfileData = response;
      MerchantProfileResponse data = _merchantProfileData.objectResult;
      merchantProfileOb.value = data;
      nameController.text = merchantProfileOb.value.name!;
      image.value = merchantProfileOb.value.image!;
    }
  }

  void _handleResponseError(Exception exception) {
    AppUtils.showToast("Error $errorMessage");
  }

  //add Profile Image
  void addProfileImage(File file) {
    CustomImagePhaserOb customImagePhaserOb = CustomImagePhaserOb();
    customImagePhaserOb.image = file;
    customImagePhaserOb.type = ImageType.fileImage;
    profileImage.value =
        CustomImagePhaserOb(image: file, type: ImageType.fileImage);
  }

  void removeProfileImage() {
    profileImage.value = CustomImagePhaserOb();
  }

  void updateProfile() {
    if (nameController.value.text.isEmpty) {
      AppUtils.showToast("Please enter name");
      return;
    }
    ProfileUpdateRequestOb profileUpdateRequestOb = ProfileUpdateRequestOb();
    profileUpdateRequestOb.name = nameController.value.text;
    profileUpdateRequestOb.password = passwordController.value.text.trim();
    if (profileImage.value?.image != null &&
        profileImage.value?.type == ImageType.fileImage) {
      File? file = profileImage.value?.image;
      profileUpdateRequestOb.image = AppUtils.doEncoding(file?.path);
    } else {
      profileUpdateRequestOb.image = "";
    }
    profileUpdateRequestOb.type =
    profileUpdateRequestOb.image != "" ? "image" : "data";
    logger.i("Update Profile Req Ob ${profileUpdateRequestOb.toJson()}");
    late Future<BaseApiResponse<MerchantProfileResponse?>> repoService;
    AppUtils.showLoaderDialog(title: "Updating");
    repoService = _repository.updateProfile(profileUpdateRequestOb);
    callAPIService(repoService, onSuccess: (dynamic response) {
      if (response != null) {
        fetchMerchantProfile();
        AppUtils.showToast("Success");
        Future.delayed(const Duration(milliseconds: 500), () {
          Get.back();
          Get.back();
          Get.back();
        });
      }
    }, onError: (Exception exception) {
      Get.back();
      AppUtils.showToast("Something went wrong please try again!");
      logger.e(exception.toString());
    });

  }
  void logout() {
    Get.back();
    AppUtils.showLoaderDialog(title: "Logging out");
    Future.delayed(Duration(seconds: 3), () {
      Get.back();
      removeLoginData();
      Get.offAllNamed(
        Routes.login,
      );
    });
  }

  void changePassword() {
    if (oldPasswordController.value.text.isEmpty ||
        newPasswordController.value.text.isEmpty ||
        confirmNewController.value.text.isEmpty) {
      AppUtils.showToast("Please fill all information");
      return;
    }
    if (newPasswordController.value.text.trim() !=
        confirmNewController.value.text.trim()) {
      AppUtils.showToast("Your new passwords do not match");
      return;
    }
    ProfileUpdateRequestOb profileUpdateRequestOb = ProfileUpdateRequestOb();
    profileUpdateRequestOb.oldPassword = oldPasswordController.value.text;
    profileUpdateRequestOb.password = newPasswordController.value.text;
    profileUpdateRequestOb.type = "password";
    late Future<BaseApiResponse<MerchantProfileResponse?>> repoService;
    AppUtils.showLoaderDialog(title: "Changing");
    repoService = _repository.updateProfile(profileUpdateRequestOb);
    callAPIService(repoService, onSuccess: (dynamic response) {
      if (response != null) {
        BaseApiResponse<dynamic> baseResp = response;
        if( baseResp.statusCode!){
          AppUtils.showToast("Password change successfully");
          Future.delayed(const Duration(milliseconds: 500), () {
            Get.back();
            Get.back();
          });
        }else{
          Get.back();
          AppUtils.showToast(baseResp.message??"msg");
        }

      }
    }, onError: (Exception exception) {
      Get.back();
      AppUtils.showToast("Old password do not match");
      logger.e(exception.toString());
    });
  }
}

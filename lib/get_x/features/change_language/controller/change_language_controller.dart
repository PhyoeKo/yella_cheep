import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yella_merchant/constant/enum/request_language_enum.dart';
import 'package:yella_merchant/constant/resources/app_string.dart';
import 'package:yella_merchant/core/base/base_controller.dart';
import 'package:yella_merchant/core/utils/app_utils.dart';
import 'package:yella_merchant/data_models/view_object/setup_vo.dart';
import 'package:yella_merchant/data_sources/local/cache_manager.dart';

class ChangeLanguageController extends BaseController {
  RxInt changeLanguageGroupLanguage = 0.obs;

  Locale? currentLocale;

  List<SetUpVo> languageList = [
    LanguageEnums.ENGLISH.languageData,
    LanguageEnums.MYANMAR.languageData,
    LanguageEnums.CHINESE.languageData
  ];

  changeLanguage(Locale locale) {
    Get.updateLocale(locale);
    setData(CacheManagerKey.langCode, locale.languageCode);
    setData(CacheManagerKey.countryCode, locale.countryCode);
    //Future.delayed(Duration(seconds: 2), () => Get.back());
    Get.back();
    AppUtils.showToast(AppString.changeTo.tr);
  }

  @override
  void onInit() {
    currentLocale = getLocale();
    changeLanguageGroupLanguage = checkLocale().obs;
    super.onInit();
  }

  int checkLocale() {
    if (currentLocale?.languageCode == LanguageEnums.ENGLISH.languageCode) {
      return 0;
    } else if (currentLocale?.languageCode ==
        LanguageEnums.MYANMAR.languageCode) {
      return 1;
    } else {
      return 2;
    }
  }
}

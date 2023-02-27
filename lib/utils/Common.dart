import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:explore_places/components/dialog_loading_view.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/AdmobAdComponent.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/int_extensions.dart';
import '../utils/Extensions/shared_pref.dart';
import '../utils/Extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import '../components/FacebookAdComponent.dart';
import '../main_temp.dart';
import '../models/LanguageDataModel.dart';
import 'AppColor.dart';
import 'AppConstant.dart';
import 'AppImages.dart';
import 'Extensions/Colors.dart';
import 'Extensions/Commons.dart';
import 'Extensions/Constants.dart';
import 'Extensions/decorations.dart';
import 'Extensions/text_styles.dart';

enum ThemeModes { SystemDefault, Light, Dark }

InputDecoration commonInputDecoration({String? hintText, Widget? prefixIcon, Color? bgColor}) {
  return InputDecoration(
    contentPadding: EdgeInsets.all(12),
    filled: true,
    prefixIcon: prefixIcon != null
        ? IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                10.width,
                prefixIcon,
                VerticalDivider(color: Colors.grey.withOpacity(0.3)),
                10.width,
              ],
            ),
          )
        : null,
    fillColor: bgColor ?? Colors.grey.withOpacity(0.15),
    hintText: hintText.validate(),
    hintStyle: secondaryTextStyle(size: 14),
    counterText: '',
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none), borderRadius: BorderRadius.circular(defaultRadius)),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor), borderRadius: BorderRadius.circular(defaultRadius)),
    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(defaultRadius)),
    focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(defaultRadius)),
  );
}

List<LanguageDataModel> languageList() {
  return [
    LanguageDataModel(id: 1, name: 'Chinese', subTitle: 'Chinese', languageCode: 'zh', fullLanguageCode: 'zh-Zh', flag: 'assets/flag/ic_zh.png'),
    LanguageDataModel(id: 1, name: 'English', subTitle: 'English', languageCode: 'en', fullLanguageCode: 'en-US', flag: 'assets/flag/ic_us.png'),
    LanguageDataModel(id: 2, name: 'Hindi', subTitle: 'हिंदी', languageCode: 'hi', fullLanguageCode: 'hi-IN', flag: 'assets/flag/ic_india.png'),
    LanguageDataModel(id: 3, name: 'Arabic', subTitle: 'عربي', languageCode: 'ar', fullLanguageCode: 'ar-AR', flag: 'assets/flag/ic_ar.png'),
    LanguageDataModel(id: 1, name: 'Spanish', subTitle: 'Española', languageCode: 'es', fullLanguageCode: 'es-ES', flag: 'assets/flag/ic_spain.png'),
    LanguageDataModel(id: 2, name: 'Afrikaans', subTitle: 'Afrikaans', languageCode: 'af', fullLanguageCode: 'af-AF', flag: 'assets/flag/ic_south_africa.png'),
    LanguageDataModel(id: 3, name: 'French', subTitle: 'Français', languageCode: 'fr', fullLanguageCode: 'fr-FR', flag: 'assets/flag/ic_france.png'),
    LanguageDataModel(id: 1, name: 'German', subTitle: 'Deutsch', languageCode: 'de', fullLanguageCode: 'de-DE', flag: 'assets/flag/ic_germany.png'),
    LanguageDataModel(id: 2, name: 'Indonesian', subTitle: 'bahasa Indonesia', languageCode: 'id', fullLanguageCode: 'id-ID', flag: 'assets/flag/ic_indonesia.png'),
    LanguageDataModel(id: 3, name: 'Portuguese', subTitle: 'Português', languageCode: 'pt', fullLanguageCode: 'pt-PT', flag: 'assets/flag/ic_portugal.png'),
    LanguageDataModel(id: 1, name: 'Turkish', subTitle: 'Türkçe', languageCode: 'tr', fullLanguageCode: 'tr-TR', flag: 'assets/flag/ic_turkey.png'),
    LanguageDataModel(id: 2, name: 'vietnamese', subTitle: 'Tiếng Việt', languageCode: 'vi', fullLanguageCode: 'vi-VI', flag: 'assets/flag/ic_vitnam.png'),
    LanguageDataModel(id: 3, name: 'Dutch', subTitle: 'Nederlands', languageCode: 'nl', fullLanguageCode: 'nl-NL', flag: 'assets/flag/ic_dutch.png'),

  ];
}

Widget emptyWidget({String? text}) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(no_data, height: 100, width: 100),
        Text(text ?? language.noDataFound, style: primaryTextStyle()),
      ],
    ),
  );
}

Widget errorWidget({String? text}) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.error_outline),
        16.height,
        Text(text ?? language.somethingWentWrong, style: primaryTextStyle()),
      ],
    ),
  );
}

Widget loaderWidget() {
  return Center(child: Lottie.asset(loader, height: 60, width: 60));
}

Widget ratingWidget(String rating) {
  return rating.isNotEmpty
      ? Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: boxDecorationWithRoundedCornersWidget(backgroundColor: primaryColor.withOpacity(0.8), borderRadius: radius(defaultRadius)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("$rating % ", style: secondaryTextStyle(color: whiteColor)),
              4.width,
              Icon(Icons.discount, size: 14, color: Colors.amber),
            ],
          ),
        )
      : SizedBox();
}

headingWidget(title, Function onTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title.toUpperCase(), style: boldTextStyle(size: 18, color: primaryColor)),
      Text(language.viewAll, style: secondaryTextStyle(size: 16)).onTap(onTap),
    ],
  ).paddingSymmetric(horizontal: 16);
}

Widget cachedImage(String? url, {double? height, double? width, BoxFit? fit, AlignmentGeometry? alignment, bool usePlaceholderIfUrlEmpty = true, double? radius}) {
  if (url.validate().isEmpty) {
    return placeHolderWidget(height: height, width: width, fit: fit, alignment: alignment, radius: radius);
  } else if (url.validate().startsWith('http')) {
    return CachedNetworkImage(
      imageUrl: url!,
      height: height,
      width: width,
      fit: fit,
      alignment: alignment as Alignment? ?? Alignment.center,
      filterQuality: FilterQuality.high,
      errorWidget: (_, s, d) {
        return placeHolderWidget(height: height, width: width, fit: fit, alignment: alignment, radius: radius);
      },
      placeholder: (_, s) {
        if (!usePlaceholderIfUrlEmpty) return SizedBox();
        return placeHolderWidget(height: height, width: width, fit: fit, alignment: alignment, radius: radius);
      },
    );
  } else {
    return Image.asset(url!, height: height, width: width, fit: fit, alignment: alignment ?? Alignment.center).cornerRadiusWithClipRRect(radius ?? defaultRadius);
  }
}

Widget placeHolderWidget({double? height, double? width, BoxFit? fit, AlignmentGeometry? alignment, double? radius}) {
  return Image.asset('assets/app_place_holer.png', height: height, width: width, fit: fit ?? BoxFit.cover, alignment: alignment ?? Alignment.center).cornerRadiusWithClipRRect(radius ?? defaultRadius);
}

Widget favouriteItemWidget({required String placeId, Color? color}) {
  return Observer(builder: (context) {
    return Icon(
      size: 26,
      appStore.isItemInFavourite(placeId) ? Icons.favorite : Icons.favorite_border,
      color: appStore.isItemInFavourite(placeId) ? Colors.red : (color ?? whiteColor),
    );
  });
}

Widget dialogSecondaryButton(String title, Function() onTap) {
  return SizedBox(
    width: 120,
    height: 35,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultRadius), side: BorderSide(color: appStore.isDarkMode ? Colors.white12 : Colors.black12)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent),
      child: Text(title, style: boldTextStyle(color: Colors.grey)),
      onPressed: onTap,
    ),
  );
}

Widget dialogPrimaryButton(String title, Function() onTap, {Color? color}) {
  return SizedBox(
    width: 120,
    height: 35,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultRadius)),
        elevation: 0,
        backgroundColor: color ?? primaryColor,
      ),
      child: Text(title, style: boldTextStyle(color: Colors.white)),
      onPressed: onTap,
    ),
  );
}

commonConfirmationDialog(BuildContext context, {String? message, Function()? onUpdate, bool isDeleteDialog = false}) {
  showDialog<void>(
    context: context,
    barrierDismissible: false, // false = user must tap button, true = tap outside dialog
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        actionsPadding: EdgeInsets.all(16),
        content: SizedBox(
          width: 200,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(color: (isDeleteDialog ? Colors.red : primaryColor).withOpacity(0.2), shape: BoxShape.circle),
                padding: EdgeInsets.all(16),
                child: Icon(Icons.clear, color: (isDeleteDialog ? Colors.red : primaryColor)),
              ),
              SizedBox(height: 30),
              Text(language.areYouSure, style: primaryTextStyle(size: 24)),
              SizedBox(height: 16),
              Text(message ?? "", style: boldTextStyle(), textAlign: TextAlign.center),
              SizedBox(height: 30),
              Row(
                children: [
                  dialogSecondaryButton(language.no, () {
                    Navigator.pop(context);
                  }).expand(),
                  SizedBox(width: 16),
                  dialogPrimaryButton(language.yes, () async {
                    finish(context);
                    appStore.setLoading(true);
                    onUpdate?.call();
                    appStore.setLoading(false);
                  }, color: (isDeleteDialog ? Colors.red : primaryColor))
                      .expand(),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

bool isLoggedInWithGoogle() {
  return appStore.isLoggedIn && getStringAsync(LOGIN_TYPE) == LoginTypeGoogle;
}

bool isLoggedInWithApp() {
  return appStore.isLoggedIn && getStringAsync(LOGIN_TYPE) == LoginTypeApp;
}

bool isLoggedInWithApple() {
  return appStore.isLoggedIn && getStringAsync(LOGIN_TYPE) == LoginTypeApple;
}

bool isLoggedInWithOTP() {
  return appStore.isLoggedIn && getStringAsync(LOGIN_TYPE) == LoginTypeOTP;
}

Widget showBannerAd() {
  // if (getBoolAsync(IS_ADS_ENABLE, defaultValue: true)) {
  //   return getStringAsync(ADS_TYPE) == isGoogleAds ? showAdmobBannerAd() : showFacebookBannerAd();
  // } else {
  //   return SizedBox();
  // }
  return SizedBox();

}

void loadInterstitialAds() {
  // if (getBoolAsync(IS_ADS_ENABLE, defaultValue: true)) {
  //   getStringAsync(ADS_TYPE) == isGoogleAds ? loadAdmobInterstitialAd() : loadFacebookInterstitialAd();
  // }
}

void showInterstitialAds() {
  // if (getBoolAsync(IS_ADS_ENABLE, defaultValue: true)) {
  //   getStringAsync(ADS_TYPE) == isGoogleAds ? showAdmobInterstitialAd() : showFacebookInterstitialAd();
  // }
}

void loadRewardedAds({Function()? onAdComplete}) {
  // if (getBoolAsync(IS_ADS_ENABLE, defaultValue: true)) {
  //   getStringAsync(ADS_TYPE) == isGoogleAds ? loadAdmobRewardedAd() : loadFacebookRewardedAd(onAdCompleted: onAdComplete);
  // }
}

void showRewardedAds({Function()? onAdCompleted}) {
  // if (getBoolAsync(IS_ADS_ENABLE, defaultValue: true)) {
  //   getStringAsync(ADS_TYPE) == isGoogleAds ? showAdmobRewardedAd(onAdCompleted: onAdCompleted) : showFacebookRewardedAd();
  // }
}

showLoadingDialog({String title = "Loading",required BuildContext context}) => showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) => LoadingViewDialog(
      title: title,
    ));


showWarningDialog({
  required String? title,
  required String? content,
  required BuildContext context,
  bool cancellable = false,
  bool showNegativeButton = true,
  String okButtonText = "Yes",
}) {
  return showDialog(
      context: context,
      barrierDismissible: cancellable,
      builder: (dialogContext) {
        return Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: primaryColor,
                    width: double.infinity,
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title!,
                      textAlign: TextAlign.center,

                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),
                      // textColor: Colors.white,
                      // textSize: TEXT_REGULAR_2X,
                      // fontWeight: FontWeight.w500,
                      // textAlign: TextAlign.center,
                      // maxLine: 1,
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    child: Center(
                      child: Text(
                        content!,
                        // fontWeight: FontWeight.w500,
                        // textSize: TEXT_REGULAR,
                        // textAlign: TextAlign.center,
                        // textOverflow: TextOverflow.ellipsis,
                        // lineHeight: 1.5,
                        // maxLine: 10,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  TextButton(
                    onPressed: () =>  mLaunchUrl("https://yalla.cheap"),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(okButtonText),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
Future<bool> handleLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    toast(language.enableLocationMsg);
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      toast(language.locationDeniedMsg);
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    toast(language.locationDeniedForever);
    return false;
  }
  return true;
}

double calculateDistanceKm(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var a = 0.5 - cos((lat2 - lat1) * p) / 2 + cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
  return (12742 * asin(sqrt(a)));
}

Future<void> getCurrentPosition() async {
  final hasPermission = await handleLocationPermission();
  if (!hasPermission) {
    appStore.currentPosition = null;
    return;
  }
  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
    appStore.setCurrentPosition(position);
  }).catchError((e) {
    log('${e.toString()}');
    appStore.currentPosition = null;
  });
}

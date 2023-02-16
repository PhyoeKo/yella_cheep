import 'dart:convert';
import 'dart:ui';
import 'package:explore_places/get_x/data_models/responses/login_response.dart';
import 'package:explore_places/get_x/data_models/responses/shop_profile_response.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CacheManager {
  final GetStorage _prefStorage = GetStorage('PrefStorage');

  Future<CacheManager> init() async {
    await GetStorage.init();
    return this;
  }

  ///Generic Preference
  void setData(CacheManagerKey key, dynamic value) =>
      _prefStorage.write(key.toString(), value);

  String? getString(CacheManagerKey key) => _prefStorage.read(key.toString());

  bool? getBool(CacheManagerKey key) => _prefStorage.read(key.toString());

  double? getDouble(CacheManagerKey key) => _prefStorage.read(key.toString());

  dynamic getData(CacheManagerKey key) => _prefStorage.read(key.toString());

  int? getShopId() {
    Map<String, dynamic> loginUserData =
        jsonDecode(getString(CacheManagerKey.loginResponseData) ?? "");
    var user = LoginResponse.fromJson(loginUserData);
    return user.shopId;
  }

  ShopProfileResponse? getShopProfile() {
    Map<String, dynamic> shopProfile =
        jsonDecode(getString(CacheManagerKey.shopProfileData) ?? "");
    return ShopProfileResponse.fromJson(shopProfile);
  }

  ///Specific Preferences
  Locale? getLocale() => Locale(
      getString(CacheManagerKey.langCode) ??
          Get.deviceLocale?.languageCode ??
          "en",
      getString(CacheManagerKey.countryCode) ??
          Get.deviceLocale?.countryCode ??
          "US");

  Future<bool> saveToken(String? token) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.token.toString(), token);
    return true;
  }

  Future<void> removeLoginData() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.loginResponseData.toString());
  }

  Future<void> removeToken() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.token.toString());
  }

  void clearAllData() async => _prefStorage.erase();
}

enum CacheManagerKey {
  token,
  langCode,
  countryCode,
  loginResponseData,
  shopProfileData,
  firebaseToken,
}

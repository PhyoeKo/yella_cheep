import 'package:explore_places/get_x/constant/resources/app_theme.dart';
import 'package:explore_places/get_x/constant/routing/app_pages.dart';
import 'package:explore_places/get_x/constant/routing/app_route.dart';
import 'package:explore_places/get_x/constant/translation/app_translation.dart';
import 'package:explore_places/get_x/core/binding/initial_binding.dart';
import 'package:explore_places/get_x/data_sources/local/cache_manager.dart';
import 'package:explore_places/get_x/features/change_theme/binding/change_theme_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



void main() async {
  await Get.putAsync<CacheManager>(() async => CacheManager().init());
  // await FirebaseService().initializeFirebase();
  ChangeThemeBindings().dependencies();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isLogin = false;
  @override
  void initState() {
    var data =
        Get.find<CacheManager>().getString(CacheManagerKey.loginResponseData) ??
            "";
    if (data.isNotEmpty) {
      isLogin = true;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yella',
      translationsKeys: AppTranslation.translationsKeys,
      locale: Get.find<CacheManager>().getLocale(),
      getPages: AppPages.routes,
      theme:  AppThemes.lightTheme,
      darkTheme:  AppThemes.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: !isLogin?  Routes.mainHomeScreen: Routes.login,
      initialBinding: InitialBinding(),
    );
  }
}

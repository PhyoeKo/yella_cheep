import 'package:explore_places/get_x/constant/routing/app_route.dart';
import 'package:explore_places/get_x/core/binding/initial_binding.dart';
import 'package:explore_places/get_x/features/category/binding/category_binding.dart';
import 'package:explore_places/get_x/features/category/controller/category_controller.dart';
import 'package:explore_places/get_x/features/change_language/binding/change_language_binding.dart';
import 'package:explore_places/get_x/features/change_language/screen/change_language_screen.dart';
import 'package:explore_places/get_x/features/change_theme/binding/change_theme_binding.dart';
import 'package:explore_places/get_x/features/change_theme/screen/change_theme_screen.dart';
import 'package:explore_places/get_x/features/explore_screen/binding/explore_binding.dart';
import 'package:explore_places/get_x/features/favourite/binding/favourite_binding.dart';
import 'package:explore_places/get_x/features/home/binding/home_binding.dart';
import 'package:explore_places/get_x/features/home/screen/create_voucher_screen.dart';
import 'package:explore_places/get_x/features/home/screen/scan_qr_screen.dart';
import 'package:explore_places/get_x/features/login/binding/login_binding.dart';
import 'package:explore_places/get_x/features/login/screen/login_screen.dart';
import 'package:explore_places/get_x/features/main_home/binding/main_home_binding.dart';
import 'package:explore_places/get_x/features/main_home/screen/main_home_screen.dart';
import 'package:explore_places/get_x/features/order_history/binding/order_history_binding.dart';
import 'package:explore_places/get_x/features/order_history/screen/order_history_screen.dart';
import 'package:explore_places/get_x/features/profile/binding/profile_binding.dart';
import 'package:explore_places/get_x/features/profile/screen/profile_edit_screen.dart';
import 'package:explore_places/get_x/features/search/binding/search_bindings.dart';
import 'package:explore_places/get_x/features/search/screen/search_screen.dart';
import 'package:explore_places/get_x/features/shops/binding/shop_binding.dart';
import 'package:explore_places/get_x/features/shops/screen/shop_detail_screen.dart';
import 'package:explore_places/get_x/features/shops/screen/shop_list_screen.dart';
import 'package:explore_places/get_x/features/splash_screen/binding/splash_screen_binding.dart';
import 'package:explore_places/get_x/features/splash_screen/screen/splash_screen.dart';
import 'package:get/get.dart';

import '../../features/category/screen/category_screen.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: Routes.login,
      page: () => LoginScreen(),
      bindings: [LoginBindings(), InitialBinding()],
    ),
    GetPage(
      name: Routes.orderHistory,
      page: () => OrderHistoryScreen(),
      bindings: [
        OrderHistoryBinding(),
      ],
    ),
    GetPage(
      name: Routes.changeLanguageScreen,
      page: () => ChangeLanguageScreen(),
      bindings: [
        ChangeLanguageBinding(),
      ],
    ),
    GetPage(
      name: Routes.scanQRScreen,
      page: () => ScanQRScreen(),
      bindings: [HomeBinding()],
    ),
    GetPage(
      name: Routes.changeTheme,
      page: () => ChangeThemeScreen(),
      bindings: [ChangeThemeBindings()],
    ),
    GetPage(
      name: Routes.createVoucher,
      page: () => CreateVoucherScreen(),
      bindings: [HomeBinding()],
    ),
    GetPage(
      name: Routes.shopList,
      page: () => ShopListScreen(),
      bindings: [ShopBinding()],
    ),
    GetPage(
      name: Routes.shopDetail,
      page: () => ShopDetailScreen(),
      bindings: [ShopBinding()],
    ),
    GetPage(
        name: Routes.profileEdit,
        page: () => ProfileEditScreen(),
        binding: ProfileBinding()),
    GetPage(
      name: Routes.mainHomeScreen,
      page: () => MainHomeScreen(),
      bindings: [
        MainHomeBinding(),
        HomeBinding(),
        ExploreBinding(),
        FavouriteBinding(),
        ProfileBinding(),
      ],
    ),
    GetPage(
      name: Routes.splashScreen,
      page: () => SplashScreen(),
      bindings: [SplashScreenBinding(), HomeBinding()],
    ),
    GetPage(
      name: Routes.searchScreen,
      page: () => SearchScreen(),
      bindings: [SearchBindings(), ShopBinding()],
    ),
    GetPage(
      name: Routes.categoryScreen,
      page: () => CategoryScreen(),
      bindings: [CategoryBinding(),],
    ),
  ];
}



import 'package:explore_places/get_x/constant/routing/app_route.dart';
import 'package:explore_places/get_x/core/binding/initial_binding.dart';
import 'package:explore_places/get_x/features/change_language/binding/change_language_binding.dart';
import 'package:explore_places/get_x/features/change_language/screen/change_language_screen.dart';
import 'package:explore_places/get_x/features/home/binding/home_binding.dart';
import 'package:explore_places/get_x/features/home/screen/create_voucher_screen.dart';
import 'package:explore_places/get_x/features/home/screen/scan_qr_screen.dart';
import 'package:explore_places/get_x/features/login/binding/login_binding.dart';
import 'package:explore_places/get_x/features/login/screen/login_screen.dart';
import 'package:explore_places/get_x/features/main_home/binding/main_home_binding.dart';
import 'package:explore_places/get_x/features/main_home/screen/main_home_screen.dart';
import 'package:explore_places/get_x/features/order_history/binding/order_history_binding.dart';
import 'package:explore_places/get_x/features/profile/binding/profile_binding.dart';
import 'package:get/get.dart';


class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: Routes.login,
      page: () => LoginScreen(),
      bindings: [LoginBindings(), InitialBinding()],
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
      name: Routes.createVoucher,
      page: () => CreateVoucherScreen(),
      bindings: [HomeBinding()],
    ),
    GetPage(
      name: Routes.mainHomeScreen,
      page: () => MainHomeScreen(),
      bindings: [

        MainHomeBinding(),
        HomeBinding(),
        OrderHistoryBinding(),
        ProfileBinding()
      ],
    ),

  ];
}

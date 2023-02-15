

import 'package:explore_places/get_x/constant/routing/app_route.dart';
import 'package:explore_places/get_x/core/binding/initial_binding.dart';
import 'package:explore_places/get_x/features/change_theme/screen/change_theme_screen.dart';
import 'package:explore_places/get_x/features/home/binding/home_binding.dart';
import 'package:explore_places/get_x/features/home/screen/create_voucher_screen.dart';
import 'package:explore_places/get_x/features/home/screen/scan_qr_screen.dart';
import 'package:explore_places/get_x/features/login/binding/login_binding.dart';
import 'package:explore_places/get_x/features/login/screen/login_screen.dart';
import 'package:explore_places/get_x/features/main_home/binding/main_home_binding.dart';
import 'package:explore_places/get_x/features/main_home/screen/main_home_screen.dart';
import 'package:explore_places/get_x/features/order_history/binding/order_history_binding.dart';
import 'package:explore_places/get_x/features/profile/binding/profile_binding.dart';
import 'package:explore_places/get_x/features/profile/screen/profile_detail_screen.dart';
import 'package:explore_places/get_x/features/profile/screen/profile_edit_screen.dart';

import '../../features/change_theme/binding/change_theme_binding.dart';
import '../../features/profile/screen/change_password_screen.dart';

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
    GetPage(
      name: Routes.changeTheme,
      page: () => ChangeThemeScreen(),
      bindings: [
        ChangeThemeBindings(),
      ],
    ),
    GetPage(
        name: Routes.profileDetail,
        page: () => ProfileDetailScreen(),
        binding: ProfileBinding()),
    GetPage(
        name: Routes.changePassword,
        page: () => ChangePasswordScreen(),
        binding: ProfileBinding()),
    GetPage(
        name: Routes.profileEdit,
        page: () => ProfileEditScreen(),
        binding: ProfileBinding()),
  ];
}

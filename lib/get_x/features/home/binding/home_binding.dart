import 'package:explore_places/get_x/core/binding/view_controller_binding.dart';
import 'package:explore_places/get_x/data_sources/network/home/home_repository.dart';
import 'package:explore_places/get_x/data_sources/network/home/home_repository_impl.dart';
import 'package:explore_places/get_x/features/category/controller/category_controller.dart';
import 'package:explore_places/get_x/features/home/controller/create_voucher_controller.dart';
import 'package:explore_places/get_x/features/home/controller/scan_qr_controller.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<HomeRepository>(
          () => HomeRepositoryImpl(), tag: (HomeRepository).toString(),
    );
    Get.lazyPut(() => HomeController(findInject(HomeRepository)));
    Get.lazyPut(() => ScanQRController(), fenix: true);
    Get.lazyPut(() => CreateVoucherController(), fenix: true);
  }

}
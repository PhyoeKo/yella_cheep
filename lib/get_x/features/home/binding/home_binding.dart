import 'package:explore_places/get_x/features/home/controller/create_voucher_controller.dart';
import 'package:explore_places/get_x/features/home/controller/scan_qr_controller.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ScanQRController(), fenix: true);
    Get.lazyPut(() => CreateVoucherController(), fenix: true);
  }

}
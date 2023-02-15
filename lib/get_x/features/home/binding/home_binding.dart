import 'package:get/get.dart';
import 'package:yella_merchant/features/home/controller/create_voucher_controller.dart';
import 'package:yella_merchant/features/home/controller/home_controller.dart';
import 'package:yella_merchant/features/home/controller/scan_qr_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ScanQRController(), fenix: true);
    Get.lazyPut(() => CreateVoucherController(), fenix: true);
  }

}
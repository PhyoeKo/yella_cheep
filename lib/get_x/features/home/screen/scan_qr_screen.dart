import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/constant/routing/app_route.dart';
import 'package:explore_places/get_x/core/base/base_view.dart';
import 'package:explore_places/get_x/features/home/controller/scan_qr_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';


class ScanQRScreen extends BaseView<ScanQRController> {
  ScanQRScreen({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    controller.readQr();
    return QRView(
      key: controller.qrKey,
      onQRViewCreated: (QRViewController qrViewController) {
        controller.qrViewController = qrViewController;
        controller.qrViewController!.scannedDataStream.listen((scanData) {
          if (scanData.code != null) {
            controller.qrViewController?.dispose();

            Get.toNamed(Routes.createVoucher, arguments: scanData.code);
          }
        });
      },
      overlay: QrScannerOverlayShape(
        borderColor: AppColors.primaryColor,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: 250,
      ),
    );
  }
}

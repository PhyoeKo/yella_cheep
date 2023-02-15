import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../core/base/base_controller.dart';

class ScanQRController extends BaseController {

  //QR
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? barCodeResult;
  QRViewController? qrViewController;

  @override
  void onInit() {
    super.onInit();
  }

  void readQr() async {
    if (barCodeResult != null) {
      qrViewController!.pauseCamera();
    }
  }
}

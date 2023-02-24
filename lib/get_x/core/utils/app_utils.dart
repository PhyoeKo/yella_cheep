import 'dart:convert';
import 'dart:developer';

import 'package:explore_places/get_x/widget/image_preview_widget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'dart:io' as Io;

class AppUtils {
  static bool isLogout = false;
  static int? selectedID ;

  static void showSnackBar({required String message, required String title}) {
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM);
  }

  static void showToast(String msg, {BuildContext? context}) {
    ScaffoldMessenger.of(context ?? Get.context!).showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
  }

  static showLoaderDialog({String? title}) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
            margin: const EdgeInsets.only(left: 7),
            child: Text(title ?? "Loading"),
          ),
        ],
      ),
    );
    Get.dialog(alert);
  }

  static hideAlertDialog() {
    Get.back();
  }

  static showPreviewImageDialog(dynamic images,
      {int currentIndex = 0, BuildContext? context}) {
    return showDialog(
      context: context ?? Get.context!,
      builder: (contextInsideDialog) {
        return ImagePreviewWidget(
          previewImages: images,
          currentIndex: currentIndex,
        );
      },
    );
  }

  static String doEncoding(String? filePath) {
    String _fileName;
    Map<String, String> _paths = {};
    _fileName = filePath != null
        ? filePath.split('/').last
        : filePath != null
            ? _paths.keys.toString()
            : '...';

    print("FILE PATH" + _fileName);
    List<String> fileType;
    String type;
    final bytes = Io.File(filePath!).readAsBytesSync();
    String img64 = base64Encode(bytes);
    fileType = _fileName.split('.');
    type = fileType[1];
    String param = "data:" "image/" + type.toLowerCase() + ";base64";
    return param + ", " + img64;
  }



  static Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showToast("Location services are disabled. Please enable the services");
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showToast("Location permissions are denied");
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showToast(
          "Location permissions are permanently denied, we cannot request permissions.");
      return false;
    }
    return true;
  }
}

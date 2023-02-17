import 'dart:io';
import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageCropUtil {
  static Future<CroppedFile?> cropRectangularImage(File imageFile,
      {bool isBanner = false}) async {
    final CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      cropStyle: CropStyle.rectangle,
      aspectRatioPresets: [
        isBanner
            ? CropAspectRatioPreset.ratio16x9
            : CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        androidUiSettings(),
        iosUiSettings(),
      ],
      // androidUiSettings: androidUiSettings(),
      // iosUiSettings: iosUiSettings(),
    );
    return croppedImage;
  }

// static Future<File> cropCircularImage(File imageFile) async {
//   final File croppedImage = await ImageCropper().cropImage(
//     sourcePath: imageFile.path,
//     cropStyle: CropStyle.circle,
//     androidUiSettings: androidUiSettings(),
//     iosUiSettings: iosUiSettings(),
//   );
//   return croppedImage;
// }
}

IOSUiSettings iosUiSettings() => IOSUiSettings(
      title: 'Crop Image',
    );

AndroidUiSettings androidUiSettings() => AndroidUiSettings(
      toolbarTitle: 'Crop Image',
      toolbarColor: AppColors.primaryColor,
      toolbarWidgetColor: Colors.white,
      initAspectRatio: CropAspectRatioPreset.original,
      lockAspectRatio: false,
      hideBottomControls: true,
      showCropGrid: false,
    );

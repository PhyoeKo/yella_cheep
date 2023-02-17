import 'dart:io';

import 'package:explore_places/get_x/core/utils/app_utils.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static final ImagePicker _picker = ImagePicker();

  static void pickMenuImage(
      {ImageSource source = ImageSource.gallery,
      required Function(File file) onImagePickCallBack}) async {
    try {
      final pickedFile =
          await _picker.pickImage(source: source, imageQuality: 50);

      onImagePickCallBack(File(pickedFile!.path));
    } catch (e, s) {
      rethrow;
      //print('Error ${e.toString()} and $s');
      //AppUtils.showToast(e.toString());
    }
  }

  static void pickMultiImage(
      {ImageSource source = ImageSource.gallery,
      required Function(File file) onImagePickCallBack}) async {
    try {
      final List<XFile>? pickedFileList = await _picker.pickMultiImage(
        imageQuality: 50,
      );
      for (int i = 0; i < pickedFileList!.length; i++) {
        onImagePickCallBack(File(pickedFileList[i].path));
      }
    } catch (e) {
      AppUtils.showToast(e.toString());
    }
  }
}

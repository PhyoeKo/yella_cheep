import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:explore_places/get_x/constant/resources/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WidgetHelper {
  static WidgetHelper? _instance;

  WidgetHelper._internal();

  factory WidgetHelper() => _instance ??= WidgetHelper._internal();

  BoxDecoration getContainerBgDecorator({
    double bottomLeft = AppDimens.MARGIN_MEDIUM,
    double bottomRight = AppDimens.MARGIN_MEDIUM,
    double topLeft = AppDimens.MARGIN_MEDIUM,
    double topRight = AppDimens.MARGIN_MEDIUM,
    Color bgColor = Colors.white
  }) {
    return BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(bottomLeft),
        bottomRight: Radius.circular(bottomRight),
        topLeft: Radius.circular(topLeft),
        topRight: Radius.circular(topRight),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          spreadRadius: 2,
          blurRadius: 2,
          offset: const Offset(0, 1),
        ),
      ],
    );
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

}

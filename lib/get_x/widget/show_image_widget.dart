import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:explore_places/get_x/constant/enum/enum_image_type.dart';
import 'package:explore_places/get_x/core/services/dio_provider.dart';
import 'package:explore_places/get_x/widget/cached_network_image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ShowImageWidget extends StatelessWidget {
  final String imagePath;
  final fit;
  final double? width;
  final double? height;
  final ImageType imageType;
  final File? imageFile;

  const ShowImageWidget(
      {Key? key,
      required this.imagePath,
      this.imageFile,
      this.width = 100,
      this.height = 100,
      this.fit = BoxFit.cover,
      this.imageType = ImageType.networkImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (imageType) {
      case ImageType.networkImage:
        return SizedBox(
          width: width,
          height: height,
          child: CachedNetworkImage(
            imageUrl: DioProvider.baseUrl + imagePath,
            width: width,
            height: height,
            fit: fit,
            placeholder: (context, url) => const CupertinoActivityIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        );
        break;
      case ImageType.localImage:
        return Image.asset(
          imagePath,
          fit: fit,
          width: width,
          height: height,
        );
        break;
      case ImageType.fileImage:
        return Image.file(
          imageFile!,
          width: width,
          height: height,
          fit: fit,
        );
      default:
        return Image.asset(
          "images/akoneya_logo.jpg",
          fit: fit,
          width: width,
          height: height,
        );
    }
  }
}

class ShowRoundedImageWidget extends StatelessWidget {
  final String imagePath;
  final fit = BoxFit.cover;
  final bool? isLocalImage;
  final double? width;
  final double? height;
  final double cornerRadius;

  const ShowRoundedImageWidget(
      {Key? key,
      required this.imagePath,
      this.isLocalImage = false,
      this.width = 100,
      this.height = 100,
      this.cornerRadius = 20})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(cornerRadius),
      child: isLocalImage!
          ? Image.asset(imagePath, fit: fit)
          : CachedNetworkImageWidget(
              imageUrl: imagePath,
              height: height,
              width: width,
            ),
    );
  }
}


void goImageDetail(BuildContext context, url) {
  List<String> imageList = [];
  imageList.add(url);
  // pushNewScreen(
  //   context,
  //   screen: ImagePreviewWidget(
  //     imageList: imageList,
  //     currentIndex: 0,
  //     isNetworkImage: true,
  //   ),
  //   withNavBar: false, // OPTIONAL VALUE. True by default.
  // );
}

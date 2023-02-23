import 'package:explore_places/get_x/core/utils/app_utils.dart';
import 'package:explore_places/get_x/widget/cached_network_image_widget.dart';
import 'package:flutter/material.dart';

class RoundedProfileWidget extends StatelessWidget {
  final double size;
  final String? imageUrl;
  final Color borderColor;
  final double borderWidth;

  const RoundedProfileWidget({
    Key? key,
    this.size = 48,
    required this.imageUrl,
    this.borderColor = Colors.transparent,
    this.borderWidth = 1.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AppUtils.showPreviewImageDialog(
        imageUrl,
      ),
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: borderWidth,
            color: borderColor,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size / 2),
          child: CachedNetworkImageWidget(
            imageUrl: imageUrl,
          ),
        ),
      ),
    );
  }
}

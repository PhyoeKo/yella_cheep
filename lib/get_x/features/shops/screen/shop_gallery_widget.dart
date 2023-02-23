import 'package:explore_places/get_x/constant/resources/app_dimens.dart';
import 'package:explore_places/get_x/core/utils/app_utils.dart';
import 'package:explore_places/get_x/widget/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ShopGalleryWidget extends StatelessWidget {
  final  List<String>? gallery;
  const ShopGalleryWidget({Key? key, this.gallery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimens.MARGIN_MEDIUM_2,
        horizontal: AppDimens.MARGIN_CARD_MEDIUM_2,
      ),
      crossAxisCount: 2,
      mainAxisSpacing: AppDimens.MARGIN_CARD_MEDIUM_2,
      crossAxisSpacing: AppDimens.MARGIN_CARD_MEDIUM_2,
      itemBuilder: (context, index) {
        final height = ((index % 2 == 0)
            ? MediaQuery.of(context).size.width * 0.7
            : (MediaQuery.of(context).size.width * 0.7) / 2);
        return SizedBox(
          height: height,
          child: InkWell(
            onTap: () => AppUtils.showPreviewImageDialog(
              gallery,
              currentIndex: index,
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  AppDimens.MARGIN_MEDIUM,
                ),
              ),
              child: CachedNetworkImageWidget(
                imageUrl:gallery?[index],
              ),
            ),
          ),
        );
      },
      itemCount: gallery?.length,
    );
  }
}

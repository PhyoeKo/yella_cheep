
import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/constant/resources/app_dimens.dart';
import 'package:explore_places/get_x/features/shops/controller/shop_detail_controller.dart';
import 'package:explore_places/get_x/widget/text_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class WriteReviewDialog extends StatefulWidget {
  final String? title;
  final int? productId;
  final ShopDetailController? shopDetailController;

  const WriteReviewDialog({
    Key? key,
    this.productId,
    this.title,
    this.shopDetailController,
  }) : super(key: key);

  @override
  _WriteReviewDialogState createState() => _WriteReviewDialogState();
}

class _WriteReviewDialogState extends State<WriteReviewDialog> {
  final TextEditingController _reviewEditingController =
      TextEditingController();
  double reviewRating = 1.0;
  

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.MARGIN_MEDIUM_2),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.3,
          minWidth: double.infinity,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppDimens.MARGIN_MEDIUM_2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(
              children: [
                const SizedBox(
                  height: AppDimens.MARGIN_MEDIUM,
                ),
                TextViewWidget(
                  widget.title ?? "",
                  textSize: AppDimens.TEXT_REGULAR_3X,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: AppDimens.MARGIN_MEDIUM,
                ),
                Container(
                  width: double.infinity,
                  height: 0.3,
                  color: AppColors.reportBottomTitleColor,
                ),
                const SizedBox(
                  height: AppDimens.MARGIN_MEDIUM_2,
                ),
                RatingBar.builder(
                  initialRating: reviewRating,
                  minRating: reviewRating,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemSize: 32,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: AppColors.primaryColor,
                  ),
                  onRatingUpdate: (rating) {
                    reviewRating = rating;
                  },
                ),
                const SizedBox(
                  height: AppDimens.MARGIN_MEDIUM_2,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppDimens.MARGIN_MEDIUM_2),
                  child: TextField(
                    controller: _reviewEditingController,
                    autofocus: false,
                    maxLines: 3,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(AppDimens.MARGIN_MEDIUM),
                        ),
                        borderSide: BorderSide(
                            color: AppColors.blackColor.withOpacity(0.2)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(AppDimens.MARGIN_MEDIUM),
                        ),
                        borderSide: BorderSide(
                            color: AppColors.blackColor.withOpacity(0.3)),
                      ),
                      filled: true,
                      hintStyle: TextStyle(
                        color: AppColors.blackColor.withOpacity(
                          0.3,
                        ),
                        height: 1,
                      ),
                      hintText: "Write a review ",
                      contentPadding: const EdgeInsets.all(
                        AppDimens. MARGIN_CARD_MEDIUM_2,
                      ),
                      fillColor: Colors.white.withOpacity(0.2),
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppDimens.MARGIN_MEDIUM_2,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppDimens.MARGIN_CARD_MEDIUM,
                      ),
                      backgroundColor: AppColors.primaryColor,
                      textStyle: const TextStyle(color: Colors.white),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(AppDimens.MARGIN_MEDIUM),
                          bottomLeft: Radius.circular(AppDimens.MARGIN_MEDIUM),
                        ),
                      ),
                    ),
                    child:  TextViewWidget(
                     "Submit",
                      textSize: AppDimens.TEXT_REGULAR_2X,
                      textColor: Colors.white,
                      fontWeight: FontWeight.w600,
                      lineHeight: 1,
                    ),
                    onPressed: () {
                      widget.shopDetailController?.giveShopReview(comment: _reviewEditingController.text, rating: reviewRating);
                      // productProvider.postReview(
                      //   widget.productId!,
                      //   reviewRating,
                      //   _reviewEditingController.text,
                      //   context,
                      // )
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

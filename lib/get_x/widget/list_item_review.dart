import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/constant/resources/app_dimens.dart';
import 'package:explore_places/get_x/widget/text_view_widget.dart';
import 'package:explore_places/get_x/widget/widget_rounded_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ListItemReview extends StatefulWidget {
  const ListItemReview({
    this.name = "",
    this.profileUrl = "",
    this.commentText = "",
    this.duration = "",
    this.rating = 0,
    Key? key,
  }) : super(key: key);
  final String name;
  final String profileUrl;
  final String commentText;
  final String duration;
  final double? rating;

  @override
  State<ListItemReview> createState() => _ListItemReviewState();
}

class _ListItemReviewState extends State<ListItemReview> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: AppDimens.MARGIN_XLARGE,
        bottom: AppDimens.MARGIN_CARD_MEDIUM_2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RoundedProfileWidget(
                borderWidth: 0.5,
                borderColor: AppColors.primaryColor,
                imageUrl: widget.profileUrl,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    padding: const EdgeInsets.all(AppDimens.MARGIN_MEDIUM),
                    margin: const EdgeInsets.symmetric(
                      horizontal: AppDimens.MARGIN_MEDIUM,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(AppDimens.MARGIN_MEDIUM),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextViewWidget(
                          widget.name,
                          textAlign: TextAlign.start,
                          maxLine: 3,
                          textOverflow: TextOverflow.ellipsis,
                          textColor: Colors.red,
                        ),
                        const SizedBox(
                          height: AppDimens.MARGIN_SMALL,
                        ),
                        FittedBox(
                          child: RatingBarIndicator(
                            rating: widget.rating ?? 0,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: AppColors.primaryColor,
                            ),
                            itemCount: 5,
                            itemSize: 8.0,
                            direction: Axis.horizontal,
                          ),
                        ),
                        const SizedBox(
                          height: AppDimens.MARGIN_SMALL,
                        ),
                        TextViewWidget(
                          widget.commentText,
                          textAlign: TextAlign.start,
                          textColor: Colors.black.withOpacity(0.5),
                        ),
                        const SizedBox(
                          height: AppDimens.MARGIN_SMALL,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: AppDimens.MARGIN_MEDIUM,
                      top: AppDimens.MARGIN_SMALL,
                    ),
                    child: TextViewWidget(
                      widget.duration,
                      textSize: AppDimens.TEXT_SMALL,
                      textColor: AppColors.textColorSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

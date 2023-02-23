import 'package:explore_places/get_x/constant/resources/app_dimens.dart';
import 'package:explore_places/get_x/data_models/responses/shop_review_response.dart';
import 'package:explore_places/get_x/widget/list_item_review.dart';
import 'package:flutter/material.dart';

class RatingAndReviewWidget extends StatelessWidget {
  final List<ShopReviewResponse> shopReviewList;
  const RatingAndReviewWidget({Key? key, required this.shopReviewList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.only(top: AppDimens.MARGIN_MEDIUM_2),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              shopReviewList
                  .map(
                    (review) => ListItemReview(
                  name: review.name ?? "",
                  profileUrl: review.image ?? "",
                  commentText: review.comment ?? "",
                  duration:  review.date ?? "",
                  rating: review.rating?.toDouble() ?? 0,
                ),
              )
                  .toList(),
            ),
          ),
        ),
        const SliverPadding(
          padding: EdgeInsets.only(
            bottom: AppDimens.MARGIN_XXLARGE * 2,
          ),
        )
      ],
    );
  }
}

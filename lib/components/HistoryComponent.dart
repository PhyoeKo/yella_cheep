import 'package:explore_places/utils/Extensions/Commons.dart';
import 'package:explore_places/utils/Extensions/Widget_extensions.dart';
import 'package:explore_places/utils/Extensions/int_extensions.dart';
import 'package:explore_places/utils/Extensions/string_extensions.dart';

import '../main.dart';
import '../models/PlaceModel.dart';
import 'package:flutter/material.dart';

import '../utils/Extensions/text_styles.dart';
import 'HtmlWidget.dart';

class HistoryComponent extends StatefulWidget {
  final PlaceModel place;

  HistoryComponent({required this.place});

  @override
  HistoryComponentState createState() => HistoryComponentState();
}

class HistoryComponentState extends State<HistoryComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    Widget detailWidget({required String title, required String subtitle, Function()? onTap}) {
      return RichText(
        text: TextSpan(
          text: "$title:\t",
          style: boldTextStyle(),
          children: [
            WidgetSpan(
              child: Text(
                subtitle,
                style: primaryTextStyle(color: onTap != null ? Colors.blue : null),
              ).onTap(() {
                onTap?.call();
              }),
            ),
          ],
        ),
      ).paddingOnly(left: 8, right: 8, top: 16);
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HtmlWidget(postContent: widget.place.description!).visible(widget.place.description.validate().isNotEmpty),
          detailWidget(
              title: language.website,
              subtitle: widget.place.website.validate(),
              onTap: () {
                mLaunchUrl(widget.place.website.validate());
              }).visible(widget.place.website.validate().isNotEmpty),
          detailWidget(
              title: language.email,
              subtitle: widget.place.email.validate(),
              onTap: () {
                mLaunchUrl('mailto:${widget.place.email.validate()}');
              }).visible(widget.place.email.validate().isNotEmpty),
          detailWidget(
              title: language.phone,
              subtitle: widget.place.phone.validate(),
              onTap: () {
                mLaunchUrl('tel:${widget.place.email.validate()}');
              }).visible(widget.place.phone.validate().isNotEmpty),
          detailWidget(title: language.bestTimeToVisit, subtitle: widget.place.toMonth != null ? "${widget.place.fromMonth} to ${widget.place.toMonth}" : "${widget.place.fromMonth}")
              .visible(widget.place.fromMonth.validate().isNotEmpty),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(text: TextSpan(text: "${language.attractions}:\t",style: boldTextStyle())),
              8.height,
              RichText(text: TextSpan(text: "${widget.place.attractions.validate()}",style: primaryTextStyle())),
            ],
          ).paddingOnly(left: 8,right: 8,top: 16).visible(widget.place.attractions.validate().isNotEmpty),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(text: TextSpan(text: "${language.howToReach}",style: boldTextStyle())),
              8.height,
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: (widget.place.howToReach ?? []).length,
                itemBuilder: (context, index) {
                  HowToReachModel item = widget.place.howToReach![index];
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022', style: boldTextStyle(size: 20)),
                      8.width,
                      RichText(
                        text: TextSpan(
                          text: "${item.key}:\t",
                          style: boldTextStyle(size: 14),
                          children: [
                            TextSpan(
                              text: "${item.value}",
                              style: primaryTextStyle(),
                            ),
                          ],
                        ),
                      ).expand(),
                    ],
                  ).paddingBottom(8);
                },
              ),
            ],
          ).paddingOnly(left: 8, right: 8, top: 16).visible((widget.place.howToReach ?? []).isNotEmpty)
        ],
      ),
    );
  }
}

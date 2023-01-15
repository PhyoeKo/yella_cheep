import 'package:explore_places/components/widget_loading_circle_indicator.dart';
import 'package:flutter/material.dart';


class LoadingViewDialog extends StatefulWidget {
  final String? title;

  const LoadingViewDialog({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  _LoadingViewDialogState createState() => _LoadingViewDialogState();
}

class _LoadingViewDialogState extends State<LoadingViewDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:   [
                const LoadingCircleIndicatorWidget(size : 32),
                const SizedBox(width: 10,),
                Text(widget.title!,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                  // textSize: TEXT_REGULAR_2X,
                  // fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

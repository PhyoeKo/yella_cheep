import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/constant/resources/app_dimens.dart';
import 'package:explore_places/get_x/widget/text_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';


class QrViewDialog extends StatefulWidget {
  final String? title;

  const QrViewDialog({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  _QrViewDialogState createState() => _QrViewDialogState();
}

class _QrViewDialogState extends State<QrViewDialog> {

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.MARGIN_CARD_MEDIUM_2),
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
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(AppDimens.MARGIN_MEDIUM_2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const SizedBox(
                        height: AppDimens.MARGIN_MEDIUM,
                      ),
                      Center(
                        child: QrImage(
                          data: "${widget.title}",
                          version: QrVersions.auto,
                          size: 180,
                          gapless: true,
                          errorStateBuilder: (cxt, err) {
                            return const Center(
                              child: Text(
                                "Uh oh! Something went wrong...",
                                textAlign: TextAlign.center,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: AppDimens.MARGIN_MEDIUM,
                      ),
                      const TextViewWidget(
                        "Show this QR to merchant to get promotion",
                        textColor: AppColors.appBarColor,
                        textAlign: TextAlign.left,
                        textSize: AppDimens.TEXT_REGULAR,
                        maxLine: 5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              right: 0,
              top:0,
              child: IconButtonWidget(Icons.cancel_sharp, ()=> Navigator.of(context).pop()),
            )
          ],
        ),
      ),
    );
  }
}

class IconButtonWidget extends StatelessWidget {
  final IconData icon;
  final Function onPress;
  const IconButtonWidget(
      this.icon,
      this.onPress,
      {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () => onPress(),
      elevation: 1.0,
      constraints: const BoxConstraints(),
      shape: const CircleBorder(),
      child:Icon(
        icon,
        color: AppColors.primaryColor,
      ),
      padding: const EdgeInsets.all(AppDimens.MARGIN_MEDIUM),
    );
  }
}

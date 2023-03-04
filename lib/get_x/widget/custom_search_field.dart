import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/constant/resources/app_dimens.dart';
import 'package:explore_places/get_x/widget/widget_rounded_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField(
      {Key? key,
      this.width = double.infinity,
      required this.onClear,
      required this.onChanged,
      required this.hint,
      required this.controller,
      this.textInputType = TextInputType.text,
      this.textInputAction = TextInputAction.done,
      this.isClearEnable = true,
      this.maxLine = 1,
      this.textInputFormatter,
      this.onSubmitted})
      : super(key: key);

  final double width;
  final int maxLine;
  final Function(String) onChanged;
  final Function(String)? onSubmitted;
  final Function onClear;
  final String hint;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool isClearEnable;
  final TextEditingController controller;
  final List<TextInputFormatter>? textInputFormatter;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 50, minWidth: width),
      child: TextFormField(
        autofocus: true,
        controller: controller,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        maxLines: maxLine,
        onFieldSubmitted: (value) {
          onSubmitted != null ? onSubmitted!(value) : null;
        },
        inputFormatters: textInputFormatter ?? [],
        onChanged: (value) {
          onChanged(value);
        },
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, size: 18),
            suffixIcon: isClearEnable
                ? RoundedIconWidget(
                    onClickIcon: () => {
                      controller.clear(),
                      onClear(),
                    },
                    backgroundColor: Colors.transparent,
                    contentPadding: AppDimens.MARGIN_SMALL,
                    icon: Icon(
                      Icons.clear,
                      size: 18,
                    ),
                  )
                : null,
            fillColor: Colors.white,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(
                horizontal: AppDimens.MARGIN_CARD_MEDIUM,
                vertical: AppDimens.MARGIN_CARD_MEDIUM),
            hintText: hint,
            hintStyle: TextStyle(
              fontFamily: 'Karla',
              color: AppColors.textColorTag.withOpacity(0.7),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.textColorTag, width: 0.2),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.textColorTag, width: 0.3),
            ),
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.textColorTag, width: 0.2),
            )),
      ),
    );
  }
}

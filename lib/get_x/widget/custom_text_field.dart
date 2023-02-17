import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/constant/resources/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.width = double.infinity,
    required this.onChanged,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.isEnabled = true,
    this.maxLine = 1,
    this.textInputFormatter,
  }) : super(key: key);


  final double width;
  final int maxLine;
  final Function(String) onChanged;
  final String hint;
  final bool isPassword;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool isEnabled;
  final TextEditingController controller;
  final List<TextInputFormatter>? textInputFormatter;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 50, minWidth: width),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(AppDimens.MARGIN_MEDIUM)),
      ),
      child: TextField(
        enabled: isEnabled,
        controller: controller,
        textInputAction: textInputAction,
        obscureText: isPassword,
        keyboardType: textInputType,
        maxLines: maxLine,
        inputFormatters: textInputFormatter??[],
        onChanged: (value) {
          onChanged(value);
        },
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(
                horizontal: AppDimens.MARGIN_CARD_MEDIUM, vertical: AppDimens.MARGIN_CARD_MEDIUM),
            hintText: hint,
            hintStyle: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black.withOpacity(0.3),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppDimens.MARGIN_MEDIUM)),
              borderSide: BorderSide(color: AppColors.secondaryTextColor, width: 0.2),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppDimens.MARGIN_MEDIUM)),
              borderSide: BorderSide(color:  AppColors.secondaryTextColor, width: 0.3),
            ),
            disabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppDimens.MARGIN_MEDIUM)),
              borderSide: BorderSide(color: AppColors.secondaryTextColor, width: 0.2),
            )),
      ),
    );
  }
}

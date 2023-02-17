
import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/constant/resources/app_dimens.dart';
import 'package:explore_places/get_x/widget/rounded_icon_widget.dart';
import 'package:flutter/material.dart';



class CustomPasswordField extends StatefulWidget {
  CustomPasswordField({
    Key? key,
    this.width = double.infinity,
    required this.onChanged,
    required this.hint,
    required this.controller,
    this.textInputAction = TextInputAction.done,
  }) : super(key: key);

  final double width;
  final Function(String) onChanged;
  final String hint;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  bool showPassword = false;

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: widget.width,
          height: 50,
          decoration: BoxDecoration(
            borderRadius:
            const BorderRadius.all(Radius.circular(AppDimens.MARGIN_MEDIUM)),
          ),
          child: TextField(
            controller: widget.controller,
            textInputAction: widget.textInputAction,
            obscureText: widget.showPassword ? false : true,
            keyboardType: TextInputType.text,
            onChanged: (value) {
              widget.onChanged(value);
            },
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              contentPadding:
              const EdgeInsets.symmetric(horizontal: AppDimens.MARGIN_CARD_MEDIUM),
              hintText: widget.hint,
              hintStyle: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.black.withOpacity(0.3),
              ),
              enabledBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(AppDimens.MARGIN_MEDIUM)),
                borderSide: BorderSide(color: AppColors.secondaryTextColor, width: 0.2),
              ),
              focusedBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(AppDimens.MARGIN_MEDIUM)),
                borderSide: BorderSide(color: AppColors.secondaryTextColor, width: 0.3),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 48,
          child: Align(
            alignment: Alignment.centerRight,
            child: RoundedIconWidget(
              contentPadding: AppDimens.MARGIN_MEDIUM,
              backgroundColor: Colors.transparent,
              onClickIcon: () => {
                setState((){
                  widget.showPassword = !widget.showPassword;
                })
              },
              icon: Icon(
                widget.showPassword ? Icons.visibility : Icons.visibility_off,
                color: AppColors.secondaryTextColor,
                size: 18,
              ),
            ),
          ),
        )
      ],
    );
  }
}

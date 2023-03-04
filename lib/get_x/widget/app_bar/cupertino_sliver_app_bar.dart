import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/constant/resources/app_dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CupertinoSliverAppBar extends StatelessWidget {
  final String title;
  final IconData? trailingIcon;
  final Function? trailingIconOnClick;

  const CupertinoSliverAppBar(
      {Key? key,
      required this.title,
      this.trailingIcon,
      this.trailingIconOnClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverNavigationBar(
      stretch: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      largeTitle: Text(
        title,
        style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold,),
      ),
      transitionBetweenRoutes: true,
      border: Border(
        bottom: BorderSide(
          width: .6,
          color: Colors.grey.shade800.withOpacity(0.6),
        ),
      ),
      trailing: trailingIcon != null
          ? IconButton(
              onPressed: () => trailingIconOnClick!(), icon: Icon(trailingIcon,color: AppColors.primaryColor,))
          : const SizedBox(),
    );
  }
}

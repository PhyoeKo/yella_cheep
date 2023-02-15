import 'package:flutter/material.dart';
import 'package:yella_merchant/constant/resources/app_colors.dart';

class FullLoadingWidget extends StatelessWidget {
  const FullLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: const CircularProgressIndicator(
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}

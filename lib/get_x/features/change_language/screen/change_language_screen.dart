import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/constant/resources/app_dimens.dart';
import 'package:explore_places/get_x/constant/resources/app_string.dart';
import 'package:explore_places/get_x/constant/translation/app_translation.dart';
import 'package:explore_places/get_x/core/base/base_view.dart';
import 'package:explore_places/get_x/features/change_language/controller/change_language_controller.dart';
import 'package:explore_places/get_x/widget/default_app_bar_widget.dart';
import 'package:explore_places/get_x/widget/secondary_button_widget.dart';
import 'package:explore_places/get_x/widget/text_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ChangeLanguageScreen extends BaseView<ChangeLanguageController> {
  ChangeLanguageScreen({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return DefaultAppBar(title: AppString.changeLanguage.tr);
  }

  @override
  Widget body(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: controller.languageList.length,
            itemBuilder: (_, index) => changeLanguageWidget(index)));
  }

  @override
  Widget? bottomNavigationBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: AppDimens.MARGIN_SMALL,
          horizontal: AppDimens.MARGIN_MEDIUM),
      child: SecondaryButtonWidget(
          child: TextViewWidget(
            AppString.change.tr,
            textColor: Colors.white,
          ),
          onPress: () {
            controller.changeLanguage(
              AppTranslation
                      .locales[controller.changeLanguageGroupLanguage.value]
                  [translationLocaleKey],
            );
          }),
    );
  }

  Widget changeLanguageWidget(int radioValue) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(AppDimens.MARGIN_MEDIUM_2),
        margin: const EdgeInsets.only(bottom: AppDimens.MARGIN_MEDIUM),
        decoration: const BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(AppDimens.MARGIN_MEDIUM)),
          color: AppColors.whiteColor,
        ),
        child: Center(
          child: ListTile(
            title:
                TextViewWidget(controller.languageList[radioValue].name ?? ""),
            leading: Radio(
              value: radioValue,
              groupValue: controller.changeLanguageGroupLanguage.value,
              onChanged: (value) {
                controller.changeLanguageGroupLanguage.value = radioValue;
              },
              activeColor: AppColors.primaryColor,
            ),
            trailing:
                Image.asset(controller.languageList[radioValue].image ?? "",width: 40,height: 40,),
          ),
        ),
      ),
    );
  }
}

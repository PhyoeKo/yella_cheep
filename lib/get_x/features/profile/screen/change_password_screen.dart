import 'package:flutter/material.dart';
import 'package:yella_merchant/constant/resources/app_dimens.dart';
import 'package:yella_merchant/core/base/base_view.dart';
import 'package:yella_merchant/features/profile/controller/profile_controller.dart';
import 'package:yella_merchant/widget/custom_password_field.dart';
import 'package:yella_merchant/widget/default_app_bar_widget.dart';
import 'package:yella_merchant/widget/secondary_button_widget.dart';
import 'package:yella_merchant/widget/text_view_widget.dart';

class ChangePasswordScreen extends BaseView<ProfileController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return DefaultAppBar(title: "Change Password");
  }

  @override
  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.MARGIN_MEDIUM),
      child: Stack(
        children: [
          Column(
            children: [
              CustomPasswordField(
                controller: controller.oldPasswordController,
                onChanged: (value) {},
                hint: 'Enter old password',
              ),
              SizedBox(
                height: AppDimens.MARGIN_CARD_MEDIUM,
              ),
              CustomPasswordField(
                controller: controller.newPasswordController,
                onChanged: (value) {},
                hint: 'Enter new password',
              ),
              SizedBox(
                height: AppDimens.MARGIN_CARD_MEDIUM,
              ),
              CustomPasswordField(
                controller: controller.confirmNewController,
                onChanged: (value) {},
                hint: 'Confirm new password',
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: MediaQuery.of(context).size.width -
                  AppDimens.MARGIN_LARGE * 2,
              child: SecondaryButtonWidget(
                onPress: () => controller.changePassword(),
                child: TextViewWidget(
                  "Update",
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

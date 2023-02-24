import 'dart:io';

import 'package:explore_places/get_x/constant/enum/enum_image_type.dart';
import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:explore_places/get_x/constant/resources/app_dimens.dart';
import 'package:explore_places/get_x/core/base/base_view.dart';
import 'package:explore_places/get_x/core/utils/app_utils.dart';
import 'package:explore_places/get_x/core/utils/image_crop_utils.dart';
import 'package:explore_places/get_x/core/utils/image_picker.dart';
import 'package:explore_places/get_x/core/utils/validator.dart';
import 'package:explore_places/get_x/features/profile/controller/profile_controller.dart';
import 'package:explore_places/get_x/widget/default_app_bar_widget.dart';
import 'package:explore_places/get_x/widget/input_form_field_widget.dart';
import 'package:explore_places/get_x/widget/product_data_backgound_widget.dart';
import 'package:explore_places/get_x/widget/secondary_button_widget.dart';
import 'package:explore_places/get_x/widget/show_image_widget.dart';
import 'package:explore_places/get_x/widget/text_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';



class ProfileEditScreen extends BaseView<ProfileController> {
  ProfileEditScreen({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return const DefaultAppBar(
      title: "Account Edit",
    );
  }

  @override
  Color pageBackgroundColor() {
    // TODO: implement pageBackgroundColor
    return const Color(0xffE5E5E5);
  }

  @override
  Widget body(BuildContext context) {
    controller.passwordController.clear();
    return LayoutBuilder(
      builder: (context, constraint) {
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
                child: Column(
                  children: [
                    const SizedBox(
                      height: AppDimens.MARGIN_MEDIUM_2,
                    ),
                    Obx(() =>
                        Visibility(
                            visible: controller.image.value != "",
                            child: Align(
                              alignment: Alignment.center,
                              child: Stack(
                                children: [
                                  Container(
                                    width: 150,
                                    height: 150,
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      const BorderRadius.all(
                                          Radius.circular(8)),
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                    ),
                                    child: ShowRoundedImageWidget(
                                      imagePath:
                                      controller.profileOb.value.image!,
                                      width: 80,
                                      height: 80,
                                    ),
                                  ),
                                  Positioned(
                                      top: 0,
                                      right: 0,
                                      child: RawMaterialButton(
                                        materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                        onPressed: () {
                                          controller.image.value = "";
                                        },
                                        elevation: 0,
                                        constraints: const BoxConstraints(),
                                        //removes empty spaces around of icon
                                        shape: const CircleBorder(),
                                        //circular button
                                        splashColor: Colors.grey,
                                        highlightColor: Colors.grey,
                                        highlightElevation: 0,
                                        fillColor: Colors.red,
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                        ),
                                        padding: EdgeInsets.all(2),
                                      ))
                                ],
                              ),
                            ))),
                    Obx(() =>
                        Visibility(
                            visible: controller.profileImage.value != null,
                            child: controller.profileImage.value!.image != null
                                ? Align(
                              alignment: Alignment.center,
                              child: Stack(
                                children: [
                                  Container(
                                    width: 150,
                                    height: 150,
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                    ),
                                    child: ShowImageWidget(
                                      width: double.infinity,
                                      height: 150,
                                      imageType:
                                      controller.profileImage.value!.type!,
                                      imageFile: controller
                                          .profileImage.value!.type ==
                                          ImageType.fileImage
                                          ? controller.profileImage.value!.image
                                          : null,
                                      imagePath: controller
                                          .profileImage.value!.type! ==
                                          ImageType.networkImage
                                          ? controller.profileImage.value?.image
                                          : "",
                                    ),
                                  ),
                                  Positioned(
                                      top: 0,
                                      right: 0,
                                      child: RawMaterialButton(
                                        materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                        onPressed: () =>
                                            controller.removeProfileImage(),
                                        elevation: 0,
                                        constraints: const BoxConstraints(),
                                        //removes empty spaces around of icon
                                        shape: const CircleBorder(),
                                        //circular button
                                        splashColor: Colors.grey,
                                        highlightColor: Colors.grey,
                                        highlightElevation: 0,
                                        fillColor: Colors.red,
                                        padding: EdgeInsets.all(2),
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                        ),
                                      ))
                                ],
                              ),
                            )
                                : const SizedBox())),
                    Obx(() =>
                        Visibility(
                            visible: controller.profileImage.value!.image ==
                                null &&
                                controller.image.value == "",
                            child: GestureDetector(
                              onTap: () =>
                                  ImagePickerHelper.pickMenuImage(
                                      onImagePickCallBack: (File file) async {
                                        final CroppedFile? croppedFile =
                                        await ImageCropUtil
                                            .cropRectangularImage(file,
                                            isBanner: true);
                                        if (croppedFile?.path != null) {
                                          controller
                                              .addProfileImage(
                                              File('${croppedFile?.path}'));
                                        }
                                      }),
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    border: Border.all(
                                        color: Colors.black, width: 0.5),
                                    borderRadius: BorderRadius.circular(8)),
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  size: 80,
                                  color: Colors.grey,
                                ),
                              ),
                            ))),
                    const SizedBox(
                      height: AppDimens.MARGIN_MEDIUM_2,
                    ),
                    ProductDataBackground(
                      widget: Column(
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.circle,
                                size: 8,
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(
                                width: AppDimens.MARGIN_SMALL,
                              ),
                              TextViewWidget("User Name")
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: AppDimens.MARGIN_CARD_MEDIUM,
                            ),
                            child: InputFormFieldWidget(
                              controller.nameController,
                              commonValidation: Validator.commonValidation,
                            ),
                          ),
                          SizedBox(
                            height: AppDimens.MARGIN_CARD_MEDIUM,
                          ),
                          Row(
                            children: const [
                              Icon(
                                Icons.circle,
                                size: 8,
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(
                                width: AppDimens.MARGIN_SMALL,
                              ),
                              TextViewWidget("Phone Number (Can't Edit)")
                            ],
                          ),
                          GestureDetector(
                            onTap: ()=> AppUtils.showToast("Phone number can't edit"),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: AppDimens.MARGIN_CARD_MEDIUM,
                              ),
                              child: InputFormFieldWidget(
                                TextEditingController(),
                                commonValidation: Validator.commonValidation,
                                isReadOnly: true,
                                hintText:
                                controller.profileOb.value.phone ?? "",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: AppDimens.MARGIN_MEDIUM_2,
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(AppDimens.MARGIN_MEDIUM_2),
                      child: SecondaryButtonWidget(
                        onPress: () => controller.updateProfile(),
                        bgColor: AppColors.primaryColor,
                        child: const TextViewWidget(
                          "Update Profile",
                          textColor: AppColors.whiteColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  ],
                )),
          ),
        );
      },
    );
  }
}

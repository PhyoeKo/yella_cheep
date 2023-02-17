// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:hohodidi_user/app_constants/colors.dart';
// import 'package:hohodidi_user/app_constants/dimens.dart';
// import 'package:hohodidi_user/app_utils/image_picker_helper.dart';
// import 'package:hohodidi_user/app_utils/locator.dart';
// import 'package:hohodidi_user/view_model/profile_provider.dart';
// import 'package:hohodidi_user/widgets/custom_text_field.dart';
// import 'package:hohodidi_user/widgets/section_view/section_view_app_bar.dart';
// import 'package:hohodidi_user/widgets/widget_heading_text.dart';
// import 'package:hohodidi_user/widgets/widget_normal_text.dart';
// import 'package:hohodidi_user/widgets/widget_primary_button.dart';
// import 'package:hohodidi_user/widgets/widget_rounded_icon.dart';
// import 'package:hohodidi_user/widgets/widget_rounded_profile.dart';
// import 'package:provider/provider.dart';
//
// class EditProfileScreen extends StatefulWidget {
//   static const routeName = '/edit_profile_screen';
//
//   const EditProfileScreen({Key? key}) : super(key: key);
//
//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }
//
// class _EditProfileScreenState extends State<EditProfileScreen> {
//   final _profileProvider = locator<ProfileProvider>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar:  AppBarSectionView(
//         title: HeadingTextWidget(
//           "editProfile".tr(),
//           textColor: Colors.white,
//         ),
//       ),
//       body: Consumer<ProfileProvider>(
//         builder: (context, profileProvider, child) => Stack(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(MARGIN_CARD_MEDIUM),
//               child: Column(
//                 children: [
//                   GestureDetector(
//                     onTap: () => {},
//                     child: Stack(
//                       children: [
//                         RoundedProfileWidget(
//                           imageUrl: _profileProvider.userProfile,
//                           borderColor: BG_COLOR_GRAY,
//                           borderWidth: MARGIN_SMALL,
//                           size: MediaQuery.of(context).size.width * 0.23,
//                         ),
//                         Positioned(
//                           right: MARGIN_MEDIUM,
//                           bottom: MARGIN_SMALL,
//                           child: RoundedIconWidget(
//                             splashColor: ITEM_BORDER_COLOR,
//                             icon: const Icon(
//                               Icons.camera_alt_rounded,
//                               size: 12,
//                               color: Colors.white,
//                             ),
//                             contentPadding: MARGIN_SMALL,
//                             onClickIcon: () => uploadAfterPickImage(),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: MARGIN_LARGE,
//                   ),
//                   CustomTextField(
//                     controller: profileProvider.nameController ,
//                     onChanged: (value) {},
//                     hint: "name".tr(),
//                     textInputAction: TextInputAction.next,
//                   ),
//                   const SizedBox(
//                     height: MARGIN_CARD_MEDIUM,
//                   ),
//                   CustomTextField(
//                     controller: profileProvider.phNoController,
//                     onChanged: (value) {},
//                     hint: "phone".tr(),
//                     textInputAction: TextInputAction.next,
//                   ),
//                   const SizedBox(
//                     height: MARGIN_CARD_MEDIUM,
//                   ),
//                   CustomTextField(
//                     controller: profileProvider.addressController,
//                     onChanged: (value) {},
//                     hint: "address".tr(),
//                     maxLine: 6,
//                     textInputAction: TextInputAction.newline,
//                     textInputType: TextInputType.multiline,
//                   ),
//                   const SizedBox(
//                     height: MARGIN_CARD_MEDIUM,
//                   ),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: CustomTextField(
//                           controller: profileProvider.dobController,
//                           onChanged: (value) {},
//                           hint: "dateOfBirth".tr(),
//                           textInputAction: TextInputAction.next,
//                           isEnabled: false,
//                         ),
//                       ),
//                       const SizedBox(
//                         width: MARGIN_CARD_MEDIUM,
//                       ),
//                       RoundedIconWidget(
//                           icon: const Icon(
//                             Icons.date_range,
//                             color: Colors.white,
//                           ),
//                           onClickIcon: () => chooseDate())
//                     ],
//                   ),
//                   Theme(
//                     data: Theme.of(context).copyWith(
//                         unselectedWidgetColor: UNSELECTED_ICON_COLOR,
//                         disabledColor: GRADIENT_BOTTOM_COLOR),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Radio(
//                           value: Gender.male,
//                           groupValue: _profileProvider.selectedGender,
//                           onChanged: (value) =>
//                               _profileProvider.setGender(value as Gender),
//                           activeColor: PRIMARY_COLOR,
//                         ),
//                          NormalTextWidget(
//                           "male".tr(),
//                           textSize: TEXT_REGULAR_2X,
//                         ),
//                         const SizedBox(
//                           width: MARGIN_CARD_MEDIUM_2,
//                         ),
//                         Radio(
//                           value: Gender.female,
//                           groupValue: _profileProvider.selectedGender,
//                           onChanged: (value) =>
//                               _profileProvider.setGender(value as Gender),
//                           activeColor: PRIMARY_COLOR,
//                         ),
//                          NormalTextWidget(
//                           "female".tr(),
//                           textSize: TEXT_REGULAR_2X,
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: SizedBox(
//                 width: MediaQuery.of(context).size.width - MARGIN_LARGE * 2,
//                 child: PrimaryButton(
//                   "save".tr(),
//                   () => _profileProvider.uploadProfileData(context),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   void uploadAfterPickImage() async {
//     final file = await ImagePickerHelper().pickMedia(
//       isGallery: true,
//       cropImage: ImagePickerHelper.cropCustomImage,
//     );
//     if (file == null) return;
//     _profileProvider.uploadProfileImage(file, context);
//   }
//
//   void chooseDate() async {
//     DateTime? selectedDob = await showDatePicker(
//         context: context,
//         initialDate: _profileProvider.dob ?? DateTime.now(),
//         firstDate: DateTime(1990),
//         lastDate: DateTime.now(),
//           builder: (context, child) {
//             return Theme(
//               data: Theme.of(context).copyWith(
//                 colorScheme: ColorScheme.light(
//                   primary: PRIMARY_COLOR, // header background color
//                   onPrimary: Colors.white, // header text color
//                   onSurface: PRIMARY_COLOR, // body text color
//                 ),
//                 textButtonTheme: TextButtonThemeData(
//                   style: TextButton.styleFrom(
//                     primary: ICON_COLOR, // button text color
//                   ),
//                 ),
//               ),
//               child: child!,
//             );
//         });
//
//     _profileProvider.setDob(selectedDob);
//   }
// }

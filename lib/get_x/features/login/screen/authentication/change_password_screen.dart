// import 'package:explore_places/get_x/features/login/controller/login_controller.dart';
// import 'package:flutter/material.dart';
//
// import 'package:provider/provider.dart';
//
// class ChangePasswordScreen extends StatefulWidget {
//   static const routeName = '/change_password_screen';
//
//   const ChangePasswordScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
// }
//
// class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
//   final LoginController _controller;
//
//   _ChangePasswordScreenState(this._controller);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBarSectionView(
//         title: HeadingTextWidget(
//           "updatePassword".tr(),
//           textColor: Colors.white,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       body: Consumer<ProfileProvider>(
//         builder: (context, profileProvider, child) => Padding(
//           padding: const EdgeInsets.all(MARGIN_CARD_MEDIUM),
//           child: Stack(
//             children: [
//               Column(
//                 children: [
//                   CustomPasswordField(
//                     controller: _profileProvider.oldPasswordController,
//                     onChanged: (value) {},
//                     hint: 'enterOldPassword'.tr(),
//                   ),
//                   SizedBox(
//                     height: MARGIN_CARD_MEDIUM,
//                   ),
//                   CustomPasswordField(
//                     controller: _profileProvider.newPasswordController,
//                     onChanged: (value) {},
//                     hint: 'enterNewPassword'.tr(),
//                   ),
//                   SizedBox(
//                     height: MARGIN_CARD_MEDIUM,
//                   ),
//                   CustomPasswordField(
//                     controller: _profileProvider.confirmNewPasswordController,
//                     onChanged: (value) {},
//                     hint: 'confirmNewPassword'.tr(),
//                   ),
//                 ],
//               ),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: SizedBox(
//                   width: MediaQuery.of(context).size.width - MARGIN_LARGE * 2,
//                   child: PrimaryButton(
//                     "update".tr(),
//                     () => _profileProvider.updatePassword(context),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

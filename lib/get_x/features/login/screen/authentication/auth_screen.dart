// import 'package:flutter/material.dart';
//
// import 'package:provider/provider.dart';
//
// class AuthScreen extends StatefulWidget {
//   static const routeName = '/register_screen';
//
//   const AuthScreen({Key? key}) : super(key: key);
//
//   @override
//   _AuthScreenState createState() => _AuthScreenState();
// }
//
// class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
//   late AnimationController _animationController;
//   final _referCodeController = TextEditingController();
//   final _phNoController = TextEditingController();
//   final _registerNickNameController = TextEditingController();
//   final _loginPasswordController = TextEditingController();
//
//
//   @override
//   void initState() {
//     _animationController =
//         AnimationController(vsync: this, duration: const Duration(seconds: 4));
//     _animationController.animateTo(0.0);
//     _animationController.animateTo(0.2);
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Builder(builder: (context) {
//       return ChangeNotifierProvider<AuthProvider>(
//           create: (context) => _authProvider,
//           child: Consumer<AuthProvider>(
//               builder: (context, provider, child) => WillPopScope(
//                     onWillPop: () async {
//                       _onExit();
//                       return false;
//                     },
//                     child: Scaffold(
//                       body: Stack(
//                         children: [
//                           const GradientBackground(),
//                           CustomScrollView(
//                             physics: const BouncingScrollPhysics(),
//                             slivers: [
//                               SliverToBoxAdapter(
//                                 child: SizedBox(
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.2,
//                                 ),
//                               ),
//                               SliverToBoxAdapter(
//                                 child: Container(
//                                   padding:
//                                       const EdgeInsets.only(top: MARGIN_MEDIUM),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       const SizedBox(height: MARGIN_MEDIUM_3),
//                                       Column(
//                                         children: [
//                                           Stack(
//                                             children: [
//                                               RequestOTPSection(
//                                                 loginPhNoController:
//                                                     _phNoController,
//                                                 animationController:
//                                                     _animationController,
//                                                 onPressLogin: () =>
//                                                     _authProvider.requestOtp(
//                                                   _phNoController.text,
//                                                   context,
//                                                   _animationController,
//                                                 ),
//                                               ),
//                                               OTPVerifySection(
//                                                 phNo: _phNoController.text,
//                                                 pinController:
//                                                     _referCodeController,
//                                                 animationController:
//                                                     _animationController,
//                                                 isRegisteredAccount: provider.isRegisteredAccount,
//                                               ),
//                                               RegisterOrLoginSection(
//                                                 nickNameController:
//                                                     _registerNickNameController,
//                                                 phNoController: _phNoController,
//                                                 passwordController:
//                                                 _loginPasswordController,
//                                                 animationController:
//                                                     _animationController,
//                                                 provider: provider,
//                                               ),
//                                             ],
//                                           ),
//                                           AuthButtonSection(
//                                             btnText: _authProvider.isRegisteredAccount? "login".tr(): "register".tr(),
//                                             animationController:
//                                                 _animationController,
//                                             onPressed: () {
//                                               _onNext(provider);
//                                             },
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   )));
//     });
//   }
//
//   _onNext(AuthProvider provider) {
//     if (_animationController.value >= 0.0 && _animationController.value < 0.4) {
//       _animationController.animateTo(0.4);
//     } else if (_animationController.value >= 0.4 &&
//         _animationController.value < 0.6) {
//       _authProvider.checkOtp(
//         _phNoController.text,
//         _referCodeController.text,
//         context,
//         _animationController,
//       );
//     } else if (_animationController.value >= 0.6 &&
//         _animationController.value < 0.8) {
//      if(provider.isRegisteredAccount) {
//        _authProvider.login(
//          _phNoController.text,
//          _loginPasswordController.text,
//          context,
//        );
//      }else{
//        _authProvider.register(
//          _phNoController.text,
//          _registerNickNameController.text,
//          _loginPasswordController.text,
//          context,
//        );
//      }
//     }
//   }
//
//   _onExit() {
//     if (_animationController.value >= 0.4 && _animationController.value < 0.6) {
//       _animationController.animateTo(0.2);
//     } else if (_animationController.value >= 0.6 &&
//         _animationController.value < 0.8) {
//       _animationController.animateTo(0.4);
//     } else {
//         if (_sharedPreference.getString(prefAuthToken) == "") {
//           Navigator.pop(context, false);
//         } else {
//           Navigator.pop(context, true);
//       }
//     }
//   }
// }

import 'package:explore_places/main.dart';
import 'package:explore_places/models/UserModel.dart';
import 'package:explore_places/screens/RegisterScreen.dart';
import 'package:explore_places/services/AuthServices.dart';
import 'package:explore_places/utils/AppConstant.dart';
import 'package:explore_places/utils/Extensions/Commons.dart';
import 'package:explore_places/utils/Extensions/Constants.dart';
import 'package:explore_places/utils/Extensions/Widget_extensions.dart';
import 'package:explore_places/utils/Extensions/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthClass {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signOut({required BuildContext context}) async {
    try {
      await _auth.signOut();
      //await storage.delete(key: "token");
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  // void storeTokenAndData(UserCredential userCredential) async {
  //   print("storing token and data");
  // }
  //
  // Future<String> getToken() async {
  //   return await storage.read(key: "token");
  // }

  Future<void> verifyPhoneNumber(
      String phoneNumber, BuildContext context, Function setData) async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      showSnackBar(context, "Verification Completed");
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      print("verificationFailed **** ${exception.message} ");
      showSnackBar(context, exception.toString());
    };
    PhoneCodeSent? codeSent =
        (String verificationID, [int? forceResnedingtoken]) {
      showSnackBar(context, "Verification Code sent on the phone number");
      setData(verificationID);
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationID) {
      showSnackBar(context, "Time out");
    };
    try {
      await _auth.verifyPhoneNumber(
          timeout: Duration(seconds: 60),
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e, s) {
      print("Error **** ${e.toString()} and $s");
      showSnackBar(context, e.toString());
    }
  }

  Future<void> signInwithPhoneNumber(
      String verificationId, String smsCode, BuildContext context) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      if (userCredential.additionalUserInfo!.isNewUser) {
        showSnackBar(context, "Please register first");
        RegisterScreen(
          phoneNumber: userCredential.user?.phoneNumber ?? "",
          credential: credential,

        ).launch(context);
      } else {
        UserModel userModel = UserModel();

        User user = userCredential.user!;
        userModel.contactNo = userCredential.user?.phoneNumber;
        await userService.userByPhone(user.phoneNumber).then((value) async {
          userModel = value;

          await setValue(USER_PASSWORD, "");
          await setValue(LOGIN_TYPE, LoginTypeApp);
          //
          // await updateUserData(userModel);
          //
          await setUserDetailPreference(userModel);

        }).catchError((e) {
          throw e;
        });
        // await signInWithEmail(userCredential.user?.email??"", passwordController.text)
        //     .then((user) {
        //   appStore.setLoading(false);
        //   finish(context, true);
        // }).catchError((e) {
        //   appStore.setLoading(false);
        //   toast(e.toString());
        // });
        // OurUser _user = OurUser();
        // get the information of the user from the database this already exists
        // currentUser = await OurDatabase().getUserInfo(_authResult.user.uid);
        // if(currentUser!= null) {
        //   Navigator.pushNamedAndRemoveUntil(
        //       context, "/homescreen", (route) => false);
        // }
      }


    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

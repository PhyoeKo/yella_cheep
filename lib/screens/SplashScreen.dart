import '../main.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/shared_pref.dart';
import '../utils/AppColor.dart';
import '../utils/AppImages.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/Extensions/int_extensions.dart';
import 'package:flutter/material.dart';
import '../utils/AppConstant.dart';
import '../utils/Extensions/text_styles.dart';
import 'DashboardScreen.dart';
import 'WalkThroughScreen.dart';

class SplashScreen extends StatefulWidget {
  static String tag = '/SplashScreen';

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    setStatusBarColorWidget(
        appStore.isDarkMode ? scaffoldColorDark : Colors.white,
        statusBarIconBrightness: Brightness.dark);
    await 2.seconds.delay;
    DashboardScreen().launch(context, isNewTask: true);
    // if (getBoolAsync(IS_FIRST_TIME, defaultValue: true)) {
    //   WalkThroughScreen().launch(context, isNewTask: true);
    // } else {
    //   DashboardScreen().launch(context, isNewTask: true);
    // }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      splash_screen_image,
      fit: BoxFit.fitHeight,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
    );
  }
}

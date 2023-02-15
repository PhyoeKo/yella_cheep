


import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/preferred_size.dart';
import 'package:yella_merchant/core/base/base_view.dart';
import 'package:yella_merchant/features/profile/controller/profile_controller.dart';
import 'package:yella_merchant/widget/default_app_bar_widget.dart';
import 'package:yella_merchant/widget/text_view_widget.dart';

class ShopProfileScreen extends BaseView<ProfileController>{
  ShopProfileScreen({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return DefaultAppBar(title: "Shop Profile");
  }

  @override
  Widget body(BuildContext context) {
    return Center(child: TextViewWidget("Profile"),);
  }

}
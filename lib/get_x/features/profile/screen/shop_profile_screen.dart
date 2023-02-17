


import 'package:explore_places/get_x/core/base/base_view.dart';
import 'package:explore_places/get_x/features/profile/controller/profile_controller.dart';
import 'package:explore_places/get_x/widget/default_app_bar_widget.dart';
import 'package:explore_places/get_x/widget/text_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/preferred_size.dart';


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
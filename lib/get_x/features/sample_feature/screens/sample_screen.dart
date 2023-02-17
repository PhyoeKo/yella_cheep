import 'package:explore_places/get_x/constant/resources/app_dimens.dart';
import 'package:explore_places/get_x/constant/routing/app_route.dart';
import 'package:explore_places/get_x/core/base/base_view.dart';
import 'package:explore_places/get_x/features/login/screen/login_screen.dart';
import 'package:explore_places/get_x/features/sample_feature/controller/sample_controller.dart';
import 'package:explore_places/get_x/widget/default_app_bar_widget.dart';
import 'package:explore_places/get_x/widget/text_view_widget.dart';
import 'package:explore_places/get_x/widget/view_handling/smart_refresher_parent_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../constant/resources/app_string.dart';

class SampleScreen extends BaseView<SampleController> {
  SampleScreen({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return DefaultAppBar(
      title: AppString.hello.tr,
      trillingIcon: Icons.language,
      trillingIconOnClick: () => Get.toNamed(Routes.changeTheme),
    );
  }

  @override
  Widget body(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Container(
            height: 68,
            color: Colors.green,
            child: Center(
              child: TextViewWidget(AppString.welcomeText.tr,
                  textSize: 18, textColor: Colors.white),
            ),
          ),
          Flexible(
            child: SmartRefresherParentView(
              refreshController: controller.refreshController,
              enablePullUp: true,
              onRefresh: () => controller.resetAndGetDummyList(),
              onLoading: () => controller.getDummyList(),
              child: CustomScrollView(slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.all(
                          AppDimens.MARGIN_MEDIUM,
                        ),
                        height: 80,
                        color: const Color(0xffe45c5c),
                        child: InkWell(
                          onTap: ()=> Get.to(LoginScreen()),
                          child: Center(
                            child: TextViewWidget(
                              controller.dummies[index].mapTitle!,
                              textColor: Colors.white,
                              fontWeight: FontWeight.bold,
                              textSize: AppDimens.TEXT_REGULAR_2X,
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: controller.dummies.length,
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
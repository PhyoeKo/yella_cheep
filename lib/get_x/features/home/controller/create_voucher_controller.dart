

import 'package:explore_places/get_x/constant/routing/app_route.dart';
import 'package:explore_places/get_x/core/binding/view_controller_binding.dart';
import 'package:explore_places/get_x/core/utils/app_utils.dart';
import 'package:explore_places/get_x/data_models/exception/base_exception.dart';
import 'package:explore_places/get_x/data_models/responses/shop_profile_response.dart';
import 'package:explore_places/get_x/data_sources/network/orders/order_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/base/base_controller.dart';
import '../../../data_models/base_response/base_api_response.dart';

class CreateVoucherController extends BaseController {
  String? qrCode;
  ShopProfileResponse? shopProfileResponse;
  RxDouble netAmount = 0.0.obs;
  final TextEditingController totalAmountController = TextEditingController();
  final OrderRepository _orderRepository = findInject(OrderRepository);

  @override
  void onInit() {

    var argument = Get.arguments;
    if (argument != null) {
      if (argument is String) {
        qrCode = argument;
      }
    }
    shopProfileResponse = getShopProfile();
    super.onInit();
  }

  void calculateAmount(String spendAmount){
    int totalAmount = int.parse(spendAmount);
    double percent = int.parse(shopProfileResponse!.discount!)/100;
     netAmount.value = totalAmount - (totalAmount*percent);

    print("Total amount $totalAmount and percect $percent and ${totalAmount*percent} and net amount is $netAmount");
    //return netAmount;
  }


  void createInvoice() async{
    AppUtils.showLoaderDialog(title: "Creating");
   final _repoService =  _orderRepository.createInvoice(shopId: getShopId()??1, qrCodr: qrCode,price: netAmount.value);
   await callAPIService(
       _repoService,
       onStart: null,
       onSuccess: (response){
         if(response!=null){

         }
       },
       onError: (BaseException exception){},
   );
  }
}

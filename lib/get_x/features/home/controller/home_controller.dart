import 'dart:convert';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yella_merchant/constant/enum/view_state.dart';
import 'package:yella_merchant/core/base/base_controller.dart';
import 'package:yella_merchant/core/binding/view_controller_binding.dart';
import 'package:yella_merchant/core/utils/app_utils.dart';
import 'package:yella_merchant/core/utils/date_utils.dart';
import 'package:yella_merchant/data_models/base_response/base_api_response.dart';
import 'package:yella_merchant/data_models/exception/base_exception.dart';
import 'package:yella_merchant/data_models/responses/order_history_response.dart';
import 'package:yella_merchant/data_models/responses/shop_profile_response.dart';
import 'package:yella_merchant/data_sources/local/cache_manager.dart';
import 'package:yella_merchant/data_sources/network/orders/order_repository.dart';
import 'package:yella_merchant/data_sources/network/shop/shop_repository.dart';

class HomeController extends BaseController {
  final RxList<OrderHistoryResponse> _orderList = RxList.empty();

  List<OrderHistoryResponse> get orderList => _orderList.obs.value;
  final OrderRepository _orderRepository = findInject(OrderRepository);
  final ShopRepository _shopRepository = findInject(ShopRepository);

  @override
  void onInit() {
    getOrderList();
    fetchShopProfile();
    super.onInit();
  }

  void fetchShopProfile() async {
    final _repoService = _shopRepository.getShopProfile();
    await callAPIService(
      _repoService,
      onStart: null,
      onSuccess: _handleShopProfileResponseSuccess,
      onError: _handleCShopProfileResponseError,
    );
  }

  void _handleCShopProfileResponseError(BaseException exception) {
    AppUtils.showToast(exception.message);
    return;
  }

  void _handleShopProfileResponseSuccess(response) async {
    if (response != null) {
      BaseApiResponse<ShopProfileResponse> shopProfileData = response;
      ShopProfileResponse shopProfileResponse = shopProfileData.objectResult;
      print("this is sho ${shopProfileResponse.name}");
      setData(CacheManagerKey.shopProfileData, jsonEncode(shopProfileResponse));

    }
  }

  void getOrderList({
    RefreshController? refreshController,
  }) async {
    setRefreshController(refreshController);
    final _repoService = _orderRepository.getOrderList(
      shopId: getShopId()!,
      orderStatus: "",
      categoryId: 0,
      fromDate: DateUtil.convertDateFormat(
          DateUtil.getCurrentDate().toString(), YEAR_MONTH_DAY),
      toDate: DateUtil.convertDateFormat(
          DateUtil.getCurrentDate().toString(), YEAR_MONTH_DAY),
    );
    await callAPIService(
      _repoService,
      onStart: null,
      onSuccess: _handleCancelOrderListResponseSuccess,
      onError: _handleCancelOrderListResponseError,
    );
  }

  void _handleCancelOrderListResponseError(BaseException exception) {
    resetRefreshController(_orderList);

    if (_orderList.isEmpty) {
      updatePageState(
        ViewState.FAILED,
        onClickTryAgain: () => resetAndGetCancelOrderList(),
      );
    } else {
      AppUtils.showToast(exception.message);
    }
    return;
  }

  void _handleCancelOrderListResponseSuccess(response) async {
    resetRefreshController(_orderList);
    if (response != null) {
      BaseApiResponse<OrderHistoryResponse> _orderData = response;
      List<OrderHistoryResponse> data = _orderData.listResult;
      _orderList.addAll(data.toList());
      if (data.isEmpty) {
        // Future.delayed(
        //   const Duration(seconds: 1),
        //   () => updatePageState(ViewState.EMPTY_LIST,
        //       onClickTryAgain: () => {
        //             resetAndGetCancelOrderList(),
        //           }),
        // );
      }
    }
  }

  Future<void> resetAndGetCancelOrderList(
      {RefreshController? refreshController}) async {
    _orderList.clear();
    getOrderList(refreshController: refreshController);
  }
}

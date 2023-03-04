import 'package:explore_places/get_x/constant/enum/shop_type_enum.dart';
import 'package:explore_places/get_x/constant/enum/view_state.dart';
import 'package:explore_places/get_x/core/base/base_controller.dart';
import 'package:explore_places/get_x/core/utils/app_utils.dart';
import 'package:explore_places/get_x/data_models/base_response/base_api_response.dart';
import 'package:explore_places/get_x/data_models/exception/base_exception.dart';
import 'package:explore_places/get_x/data_models/responses/shop_data_response.dart';
import 'package:explore_places/get_x/data_sources/network/shop/shop_repository.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ShopController extends BaseController {
  late ShopRepository _repository;

  ShopController(ShopRepository repository) {
    _repository = repository;
  }

  final RxList<ShopDataResponse> _nearByShopList = RxList.empty();

  List<ShopDataResponse> get nearByShopList => _nearByShopList.obs.value;

  late ShopType shopType;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      shopType = Get.arguments;

      if (shopType == ShopType.nearBy) {
        resetNearNearByShopList();
      } else if (shopType == ShopType.byState) {
        getShopList(selectedStateId: AppUtils.selectedID);
      } else if (shopType == ShopType.categoryBy) {
        getShopList(categoryId: AppUtils.selectedID);
      }
    }
  }

  void getShopList({int? selectedStateId, int? categoryId}) async {
    final _repoService = _repository.getShopList(
        categoryId: categoryId, stateId: selectedStateId);
    await callAPIService(
      _repoService,
      onStart: showPartialLoading,
      onSuccess: _handleNearByShopListResponseSuccess,
      onError: (BaseException exception) {},
    );
  }

  void getNearByShop({RefreshController? refreshController}) async {
    print("Load paginate");
    setRefreshController(refreshController);
    final _repoService = _repository.getNearByShopList(
        16.823355172423504, 96.15423770061818, 200);
    await callAPIService(
      _repoService,
      onStart: showPartialLoading,
      onSuccess: _handleNearByShopListResponseSuccess,
      onError: (BaseException exception) {},
    );
  }

  void _handleNearByShopListResponseSuccess(response) async {
    resetRefreshController(_nearByShopList);
    if (_nearByShopList.isNotEmpty) {
      _nearByShopList.clear();
    }
    if (response != null) {
      BaseApiResponse<ShopDataResponse> _responseData = response;
      List<ShopDataResponse> data = _responseData.listResult;
      _nearByShopList.addAll(data.toList());

      if (data.isEmpty && shopType == ShopType.byState) {
        Future.delayed(
          const Duration(seconds: 1),
          () => updatePageState(ViewState.EMPTYLIST,
              message: 'No data',
              onClickTryAgain: () => {resetNearNearByShopList()}),
        );
      }
    }
  }

  Future<void> resetNearNearByShopList(
      {RefreshController? refreshController}) async {
    _nearByShopList.clear();
    getNearByShop(refreshController: refreshController);
  }
}

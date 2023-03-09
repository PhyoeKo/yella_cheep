import 'package:explore_places/get_x/constant/enum/shop_type_enum.dart';
import 'package:explore_places/get_x/constant/enum/view_state.dart';
import 'package:explore_places/get_x/core/base/base_controller.dart';
import 'package:explore_places/get_x/core/utils/app_utils.dart';
import 'package:explore_places/get_x/data_models/base_response/base_api_response.dart';
import 'package:explore_places/get_x/data_models/exception/base_exception.dart';
import 'package:explore_places/get_x/data_models/responses/shop_data_response.dart';
import 'package:explore_places/get_x/data_sources/network/shop/shop_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ShopController extends BaseController {
  late ShopRepository _repository;

  ShopController(ShopRepository repository) {
    _repository = repository;
  }

  final RxList<ShopDataResponse> _shopList = RxList.empty();

  List<ShopDataResponse> get shopList => _shopList.obs.value;

  late ShopType shopType;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      shopType = Get.arguments;
      loadShopList();
    }
  }

  void loadShopList({RefreshController? refreshController}) {
    logger.i("Load ShopList by $shopType");
    if (shopType == ShopType.nearBy) {
      resetNearNearByShopList(refreshController: refreshController);
    } else if (shopType == ShopType.byState) {
      getShopList(
          selectedStateId: AppUtils.selectedID,
          refreshController: refreshController);
    } else if (shopType == ShopType.categoryBy) {
      getShopList(
          categoryId: AppUtils.selectedID,
          refreshController: refreshController);
    }
  }

  void getShopList(
      {int? selectedStateId,
      int? categoryId,
      RefreshController? refreshController}) async {
    if (refreshController != null) {
      setRefreshController(refreshController);
      logger.i('Set referesher');
    }
    final _repoService = _repository.getShopList(
        categoryId: AppUtils.selectedID, stateId: selectedStateId);
    await callAPIService(
      _repoService,
      onStart: showPartialLoading,
      onSuccess: _handleNearByShopListResponseSuccess,
      onError: (BaseException exception) {},
    );
  }

  void getNearByShop({RefreshController? refreshController}) async {
    setRefreshController(refreshController);
    final _repoService = _repository.getNearByShopList(
      16.823355172423504,
      96.15423770061818,
      200,
    );
    await callAPIService(
      _repoService,
      onStart: showPartialLoading,
      onSuccess: _handleNearByShopListResponseSuccess,
      onError: (BaseException exception) {},
    );
  }

  void _handleNearByShopListResponseSuccess(response) async {
    resetRefreshController(_shopList);
    if (_shopList.isNotEmpty) {
      _shopList.clear();
    }
    if (response != null) {
      BaseApiResponse<ShopDataResponse> _responseData = response;
      List<ShopDataResponse> data = _responseData.listResult;
      _shopList.addAll(data.toList());

      if (data.isEmpty ) {
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
    getNearByShop(refreshController: refreshController);
  }
}

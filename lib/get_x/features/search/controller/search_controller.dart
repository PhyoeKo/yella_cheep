import 'package:explore_places/get_x/constant/enum/view_state.dart';
import 'package:explore_places/get_x/core/base/base_controller.dart';
import 'package:explore_places/get_x/core/binding/view_controller_binding.dart';
import 'package:explore_places/get_x/data_models/base_response/base_api_response.dart';
import 'package:explore_places/get_x/data_models/exception/base_exception.dart';
import 'package:explore_places/get_x/data_models/responses/shop_data_response.dart';
import 'package:explore_places/get_x/data_sources/network/shop/shop_repository.dart';
import 'package:explore_places/get_x/features/shops/controller/shop_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchController extends BaseController {
  final ShopController shopController =
      ShopController(findInject(ShopRepository));

  final RxList<ShopDataResponse> _shopList = RxList.empty();

  List<ShopDataResponse> get shopList => _shopList.obs.value;

  ShopRepository shopRepo = findInject(ShopRepository);

  TextEditingController textEditingController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getShopList();
  }

  void getShopList({
    String? name,
  }) async {
    final _repoService = shopRepo.getShopList(name: name);
    await callAPIService(
      _repoService,
      onStart: showPartialLoading,
      onSuccess: _handleNearByShopListResponseSuccess,
      onError: (BaseException exception) {},
    );
  }

  void _handleNearByShopListResponseSuccess(response) async {
    if (response != null) {
      if (_shopList.isNotEmpty) _shopList.clear();
      BaseApiResponse<ShopDataResponse> _responseData = response;
      List<ShopDataResponse> data = _responseData.listResult;
      _shopList.addAll(data.toList());

      if (_shopList.isEmpty) {
        Future.delayed(
          const Duration(seconds: 1),
          () => updatePageState(ViewState.EMPTYLIST,
              message: 'No data',
              onClickTryAgain: () => {
                    //  resetNearNearByShopList()
                  }),
        );
      }
    }
  }
}

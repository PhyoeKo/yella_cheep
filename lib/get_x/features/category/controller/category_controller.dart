import 'dart:async';

import 'package:explore_places/get_x/constant/enum/view_state.dart';
import 'package:explore_places/get_x/core/base/base_controller.dart';
import 'package:explore_places/get_x/core/binding/view_controller_binding.dart';
import 'package:explore_places/get_x/core/utils/pagination_utils.dart';
import 'package:explore_places/get_x/data_models/base_response/base_api_response.dart';
import 'package:explore_places/get_x/data_models/exception/base_exception.dart';
import 'package:explore_places/get_x/data_models/responses/shop_data_response.dart';
import 'package:explore_places/get_x/data_models/view_object/setup_vo.dart';
import 'package:explore_places/get_x/data_sources/network/home/home_repository.dart';
import 'package:explore_places/get_x/data_sources/network/shop/shop_repository.dart';
import 'package:explore_places/get_x/features/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategoryController extends BaseController {
  late TabController tabController;
  ShopRepository _repository = findInject((ShopRepository).toString());

  final HomeController homeController =
      HomeController(findInject(HomeRepository));
  List<SetUpVo> categoryList = [];
  int currentSelected = 0;
  RxInt categoryId = 0.obs;

  final RxList<ShopDataResponse> _shopList = RxList.empty();

  List<ShopDataResponse> get shopList => _shopList.obs.value;

  RefreshController? _refreshController;
  RefreshController get refreshController => _refreshController?? RefreshController();
  PaginationUtils pagination = PaginationUtils();
  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      categoryList = Get.arguments[0];
      currentSelected = Get.arguments[1];
      categoryId.value = Get.arguments[2];
    }
    print("Current Selected is ${homeController.selectedCategory}");
    tabController = TabController(
      vsync: this,
      length: categoryList.length,
    );
    tabController.index = currentSelected;
    getShopList();

    tabController.addListener(() {
      categoryId.value = categoryList[tabController.index].id!;
      resetAndGetProductList();
      // }
    });
  }

  void getShopList(
      { RefreshController? refreshController}) async {
    if (refreshController != null) {
      setRefreshController(refreshController);
      logger.i('Set referesher');
    }
    final _repoService = _repository.getShopList(categoryId: categoryId.value);
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
      pagination.setCurrentPage(
          lastPage: _responseData.meta?.lastPage);
      if (data.isEmpty) {
        Future.delayed(
          const Duration(seconds: 1),
          () => updatePageState(ViewState.EMPTYLIST,
              message: 'No data', onClickTryAgain: () => {}),
        );
      }
    }
  }

  Future<void> resetAndGetProductList() async {

    updatePageState(ViewState.LOADING);
    pagination = PaginationUtils();
    _shopList.clear();
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      getShopList();
    });

  }
}

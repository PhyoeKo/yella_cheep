import 'dart:convert';

import 'package:explore_places/get_x/constant/enum/view_state.dart';
import 'package:explore_places/get_x/constant/routing/app_route.dart';
import 'package:explore_places/get_x/core/base/base_controller.dart';
import 'package:explore_places/get_x/core/binding/view_controller_binding.dart';
import 'package:explore_places/get_x/core/utils/app_utils.dart';
import 'package:explore_places/get_x/core/utils/date_utils.dart';
import 'package:explore_places/get_x/data_models/base_response/base_api_response.dart';
import 'package:explore_places/get_x/data_models/exception/base_exception.dart';
import 'package:explore_places/get_x/data_models/responses/banner_response.dart';
import 'package:explore_places/get_x/data_models/responses/order_history_response.dart';
import 'package:explore_places/get_x/data_models/responses/shop_data_response.dart';
import 'package:explore_places/get_x/data_models/responses/shop_profile_response.dart';
import 'package:explore_places/get_x/data_models/view_object/setup_vo.dart';
import 'package:explore_places/get_x/data_sources/local/cache_manager.dart';
import 'package:explore_places/get_x/data_sources/network/home/home_repository.dart';
import 'package:explore_places/get_x/data_sources/network/orders/order_repository.dart';
import 'package:explore_places/get_x/data_sources/network/shop/shop_repository.dart';
import 'package:explore_places/get_x/features/main_home/controller/main_home_controller.dart';
import 'package:explore_places/get_x/features/shops/controller/shop_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends BaseController {
  late HomeRepository _repository;

  HomeController(HomeRepository repository) {
    _repository = repository;
  }

  final ShopController shopController =
      ShopController(findInject(ShopRepository));
  final RxList<BannerResponse> _bannerList = RxList.empty();

  List<BannerResponse> get bannerList => _bannerList.obs.value;

  final RxList<SetUpVo> _categoryList = RxList.empty();

  List<SetUpVo> get categoryList => _categoryList.obs.value;

  final RxList<SetUpVo> _stateList = RxList.empty();

  List<SetUpVo> get stateList => _stateList.obs.value;

  RxDouble currentLat = 0.0.obs;
  RxDouble currentLong = 0.0.obs;

  final MainHomeController mainHomeController = Get.find();


  @override
  void onInit() {
    getLoginData();
   if(_bannerList.isEmpty){
     loadInitialData();
   }
    super.onInit();
  }
  getLoginData(){
    var data =
        Get.find<CacheManager>().getString(CacheManagerKey.loginResponseData) ??
            "";
    if (data.isNotEmpty) {
      mainHomeController.isLogin.value = true;
    }
  }

  void loadInitialData(){
    getBannerList();
    getCategoryList();
    getCurrentPosition();
  }
  Future<void> getCurrentPosition() async {
    final hasPermission = await AppUtils.handleLocationPermission();
    if (!hasPermission) {
      // appStore.currentPosition = null;
      return;
    }
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      currentLat.value = position.latitude;
      currentLong.value = position.longitude;
      shopController.getNearByShop();
      logger.i(
          "Current location is ${position.latitude} and ${position.longitude}");
    }).catchError((e) {
      logger.i('${e.toString()}');
      //  appStore.currentPosition = null;
    });
  }

  Future<void> getCategoryList() async {
    final _repoService = _repository.getCategoryList();
    await callAPIService(
      _repoService,
      onStart: null,
      onSuccess: _handleCategoryListResponseSuccess,
      onError: (BaseException exception) {},
    );
  }

  void getStateList() async {
    final _repoService = _repository.getStateList();
    await callAPIService(
      _repoService,
      onStart: null,
      onSuccess: _handleStateListResponseSuccess,
      onError: (BaseException exception) {},
    );
  }

  void _handleStateListResponseSuccess(response) async {
    if (response != null) {
      BaseApiResponse<SetUpVo> _responseData = response;
      List<SetUpVo> data = _responseData.listResult;
      _stateList.addAll(data.toList());
    }
  }

  void _handleCategoryListResponseSuccess(response) async {
    resetRefreshController(_bannerList);
    if (response != null) {
      BaseApiResponse<SetUpVo> _responseData = response;
      List<SetUpVo> data = _responseData.listResult;
      _categoryList.addAll(data.toList());
    }
  }

  void getBannerList({
    RefreshController? refreshController,
  }) async {
    setRefreshController(refreshController);
    final _repoService = _repository.getBannerData();
    await callAPIService(
      _repoService,
      onStart: null,
      onSuccess: _handleCancelOrderListResponseSuccess,
      onError: _handleCancelOrderListResponseError,
    );
  }

  void _handleCancelOrderListResponseError(BaseException exception) {
    resetRefreshController(_bannerList);

    if (_bannerList.isEmpty) {
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
    resetRefreshController(_bannerList);
    if (response != null) {
      BaseApiResponse<BannerResponse> _responseData = response;
      List<BannerResponse> data = _responseData.listResult;
      _bannerList.addAll(data.toList());
    }
  }

  Future<void> resetAndGetCancelOrderList(
      {RefreshController? refreshController}) async {
    // _bannerList.clear();
    // getBannerList(refreshController: refreshController);
  }


}

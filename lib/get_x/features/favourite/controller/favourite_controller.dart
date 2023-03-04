import 'package:explore_places/get_x/constant/enum/view_state.dart';
import 'package:explore_places/get_x/constant/routing/app_route.dart';
import 'package:explore_places/get_x/core/base/base_controller.dart';
import 'package:explore_places/get_x/core/binding/view_controller_binding.dart';
import 'package:explore_places/get_x/core/utils/app_utils.dart';
import 'package:explore_places/get_x/data_models/base_response/base_api_response.dart';
import 'package:explore_places/get_x/data_models/exception/base_exception.dart';
import 'package:explore_places/get_x/data_models/responses/favourite_shop_list.dart';
import 'package:explore_places/get_x/data_models/responses/shop_data_response.dart';
import 'package:explore_places/get_x/data_sources/network/favourite/favourite_repository.dart';
import 'package:explore_places/get_x/data_sources/network/home/home_repository.dart';
import 'package:explore_places/get_x/features/home/controller/home_controller.dart';
import 'package:explore_places/get_x/features/main_home/controller/main_home_controller.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FavouriteController extends BaseController {
  late FavouriteRepository _repository;

  FavouriteController(FavouriteRepository repository) {
    _repository = repository;
  }

  final HomeController homeController =
      HomeController(findInject(HomeRepository));

  final RxList<FavouriteShopData> _nearByShopList = RxList.empty();

  List<FavouriteShopData> get nearByShopList => _nearByShopList.obs.value;

  final MainHomeController mainHomeController = Get.find();

  @override
  void onInit() {
    super.onInit();
    if (mainHomeController.isLogin.value) {
      getFavShopList();
    }
  }

  void getFavShopList({RefreshController? refreshController}) async {
    setRefreshController(refreshController);
    final _repoService = _repository.getFavouriteList();
    await callAPIService(
      _repoService,
      onStart: showFullScreenLoading,
      onSuccess: _handleFavShopListResponseSuccess,
      onError: (BaseException exception) {},
    );
  }

  void _handleFavShopListResponseSuccess(response) async {
    resetRefreshController(_nearByShopList);
    if(_nearByShopList.isNotEmpty){
    _nearByShopList.clear();
    }
    if (response != null) {
      BaseApiResponse<FavouriteShopData> _responseData = response;
      List<FavouriteShopData> data = _responseData.listResult;
      _nearByShopList.addAll(data.toList());

      if (data.isEmpty) {
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
    getFavShopList(refreshController: refreshController);
  }
}

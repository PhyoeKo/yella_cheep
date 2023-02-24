import 'package:explore_places/get_x/constant/enum/view_state.dart';
import 'package:explore_places/get_x/core/base/base_controller.dart';
import 'package:explore_places/get_x/data_models/base_response/base_api_response.dart';
import 'package:explore_places/get_x/data_models/exception/base_exception.dart';
import 'package:explore_places/get_x/data_models/responses/shop_data_response.dart';
import 'package:explore_places/get_x/data_sources/network/favourite/favourite_repository.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FavouriteController extends BaseController {
  late FavouriteRepository _repository;

  FavouriteController(FavouriteRepository repository) {
    _repository = repository;
  }

  final RxList<ShopDataResponse> _nearByShopList = RxList.empty();

  List<ShopDataResponse> get nearByShopList => _nearByShopList.obs.value;

  @override
  void onInit() {
    super.onInit();
    getFavShopList();
  }

  void getFavShopList({RefreshController? refreshController}) async {
    setRefreshController(refreshController);
    final _repoService = _repository.getFavouriteList();
    await callAPIService(
      _repoService,
      onStart: showFullScreenLoading,
      onSuccess: _handleFavShopListResponseSuccess,
      onError: (BaseException exception) {


      },
    );
  }

  void _handleFavShopListResponseSuccess(response) async {
    resetRefreshController(_nearByShopList);
    if (response != null) {
      BaseApiResponse<ShopDataResponse> _responseData = response;
      List<ShopDataResponse> data = _responseData.listResult;
      _nearByShopList.addAll(data.toList());

      if (data.isEmpty) {
        Future.delayed(
          const Duration(seconds: 1),
              () => updatePageState(ViewState.EMPTYLIST,message: 'No data',
              onClickTryAgain: () => {
                resetNearNearByShopList()
              }),
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

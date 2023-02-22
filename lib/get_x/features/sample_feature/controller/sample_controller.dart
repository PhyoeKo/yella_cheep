import 'package:explore_places/get_x/constant/enum/view_state.dart';
import 'package:explore_places/get_x/core/base/base_controller.dart';
import 'package:explore_places/get_x/core/utils/app_utils.dart';
import 'package:explore_places/get_x/core/utils/pagination_utils.dart';
import 'package:explore_places/get_x/data_models/base_response/base_api_response.dart';
import 'package:explore_places/get_x/data_models/exception/base_exception.dart';
import 'package:explore_places/get_x/data_models/responses/dummy_list_response.dart';
import 'package:explore_places/get_x/data_sources/network/sample_feature/sample_repository.dart';
import 'package:explore_places/get_x/data_sources/network/sample_feature/sample_repository_impl.dart';
import 'package:explore_places/get_x/features/sample_feature/mapper/sample_mapper.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class SampleController extends BaseController {
  late final SampleRepository _repository = SampleRepositoryImpl();
  RxList<SampleVO> dummies = RxList.empty();

  RefreshController refreshController = RefreshController();
  late PaginationUtils samplePagination = PaginationUtils();

  @override
  void onInit() {
    super.onInit();
    getDummyList();
  }

  //#region API Call
  Future<void> resetAndGetDummyList() async {
    dummies.clear();
    samplePagination = PaginationUtils();
    getDummyList();
  }

  void getDummyList() async {
    if (samplePagination.isPageAvailable()) {
      final repoService = _repository.getDummyData();
      if (dummies.isEmpty) updatePageState(ViewState.LOADING);
      await callAPIService(
        repoService,
        onSuccess: _handleDummyListResponseSuccess,
        onError: _handleDummyListResponseError,
      );
    }
  }

  void _handleDummyListResponseSuccess(response) async {
 //   resetRefreshController(refreshController);
    if (response != null) {
      BaseApiResponse<DummyListResponse> _orderData = response;

      DummyListResponse data = _orderData.objectResult;
      dummies.addAll(SampleMapper.getMapList(data.dummyList));
      if (data.dummyList!.isEmpty) {
        Future.delayed(
          const Duration(seconds: 1),
          () => updatePageState(ViewState.EMPTYLIST),
        );
      }
      samplePagination.setCurrentPage(
        lastPage: data.pagination?.lastPage,
      );
    }
  }

  void _handleDummyListResponseError(BaseException exception) {
 //   resetRefreshController(refreshController);
    if (dummies.isEmpty) {
      updatePageState(
        ViewState.FAILED,
        onClickTryAgain: () => resetAndGetDummyList(),
      );
    } else {
      AppUtils.showToast(exception.message);
    }
    return;
  }

}

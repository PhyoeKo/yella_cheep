import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yella_merchant/constant/enum/view_state.dart';
import 'package:yella_merchant/core/base/base_controller.dart';
import 'package:yella_merchant/core/utils/app_utils.dart';
import 'package:yella_merchant/core/utils/pagination_utils.dart';
import 'package:yella_merchant/data_models/base_response/base_api_response.dart';
import 'package:yella_merchant/data_models/exception/base_exception.dart';
import 'package:yella_merchant/data_models/responses/order_history_response.dart';
import 'package:yella_merchant/data_sources/network/orders/order_repository.dart';

class OrderHistoryController extends BaseController {
  late OrderRepository _repository;

  OrderHistoryController(OrderRepository repository) {
    _repository = repository;
  }

  bool pageAvailable = true;

  final RxList<OrderHistoryResponse> _orderList = RxList.empty();

  List<OrderHistoryResponse> get orderList => _orderList.obs.value;

  late PaginationUtils _orderPagination = PaginationUtils();

  @override
  void onInit() {
    getOrderList();
    super.onInit();
  }

  Future<void> getOrderList({
    RefreshController? refreshController,
  }) async {
    setRefreshController(refreshController);
    if (_orderPagination.isPageAvailable()) {
      final repoService = _repository.getOrderList(
        shopId: getShopId()!,
        orderStatus: "pending",
        categoryId: 0,
        fromDate: "",
        toDate: "",
      );
      await callAPIService(
        repoService,
        onStart: _orderList.isEmpty ? () => showLoading() : null,
        onSuccess: _handlePendingOrderListResponseSuccess,
        onError: _handlePendingOrderListResponseError,
      );
    }
  }

  ///API CALL
  void _handlePendingOrderListResponseError(BaseException exception) {
    resetRefreshController(_orderList);

    if (_orderList.isEmpty) {
      updatePageState(
        ViewState.FAILED,
        onClickTryAgain: () => resetAndGetPendingOrderList(),
      );
    } else {
      AppUtils.showToast(exception.message);
    }
    return;
  }

  void _handlePendingOrderListResponseSuccess(response) async {
    resetRefreshController(_orderList);
    if (response != null) {
      BaseApiResponse<OrderHistoryResponse> _orderData = response;
      List<OrderHistoryResponse> data = _orderData.listResult;
      _orderList.addAll(data.toList());
      if (data.isEmpty) {
        Future.delayed(
          const Duration(seconds: 1),
          () => updatePageState(ViewState.EMPTY_LIST,
              onClickTryAgain: () => {
                    resetAndGetPendingOrderList(),
                  }),
        );
      }
      _orderPagination.setCurrentPage(
        lastPage: _orderData.meta?.lastPage,
      );
    }
  }

  Future<void> resetAndGetPendingOrderList({
    RefreshController? refreshController,
  }) async {
    _orderList.clear();
    _orderPagination = PaginationUtils();
    getOrderList(
      refreshController: refreshController,
    );
  }
}

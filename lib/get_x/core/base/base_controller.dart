
import 'package:explore_places/get_x/constant/enum/view_state.dart';
import 'package:explore_places/get_x/data_models/exception/api_exception.dart';
import 'package:explore_places/get_x/data_models/exception/app_exception.dart';
import 'package:explore_places/get_x/data_models/exception/base_exception.dart';
import 'package:explore_places/get_x/data_models/exception/json_format_exception.dart';
import 'package:explore_places/get_x/data_models/exception/network_exception.dart';
import 'package:explore_places/get_x/data_models/exception/service_unavailable_exception.dart';
import 'package:explore_places/get_x/data_models/exception/timeout_exception.dart';
import 'package:explore_places/get_x/data_models/exception/unauthorize_exception.dart';
import 'package:explore_places/get_x/data_sources/local/cache_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:logger/logger.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../data_models/exception/not_found_exception.dart';

abstract class BaseController extends GetxController
    with CacheManager, GetSingleTickerProviderStateMixin {
  //Reload the page
  RefreshController _refreshController = RefreshController();

  RefreshController get refreshController => _refreshController;

  final Logger logger = Logger(
    printer: PrettyPrinter(
        methodCount: 8,
        // number of method calls to be displayed
        errorMethodCount: 12,
        // number of method calls if stacktrace is provided
        lineLength: 120,
        // width of the output
        colors: true,
        // Colorful log messages
        printEmojis: true,
        // Print an emoji for each log message
        printTime: false // Should each log print contain a timestamp
    ),
  );

  //Controls page state
  final Rx<PageStateHandler> _pageSateController =
      PageStateHandler(ViewState.DEFAULT).obs;

  PageStateHandler get pageState => _pageSateController.value;

  updatePageState(ViewState state,
      {Function? onClickTryAgain,
        String? message,
        Widget? shimmerEffect}) =>
      _pageSateController(PageStateHandler(state,
          onClickTryAgain: onClickTryAgain,
          message: message,
          shimmerEffect: shimmerEffect));

  showPartialLoading({Widget? shimmerEffect}) =>
      updatePageState(ViewState.LOADING,
          onClickTryAgain: () => {}, shimmerEffect: shimmerEffect);

  showFullScreenLoading() => updatePageState(ViewState.FULL_SCREEN_LOADING);

  dynamic callAPIService<T>(
      Future<T> future, {
        Function(BaseException exception)? onError,
        Function(T response)? onSuccess,
        Function? onStart,
        Function? onComplete,
      }) async {
    onStart != null ? onStart() : null;
    try {
      final T response = await future;
      if (onSuccess != null) onSuccess(response);
      updatePageState(ViewState.SUCCESS);
      return response;
    } on ServiceUnavailableException catch (exception) {
      _showErrorMessage(exception, onError);
    } on UnauthorizedException catch (exception) {
      _showErrorMessage(exception, onError);
    } on TimeoutException catch (exception) {
      _showErrorMessage(exception, onError);
    } on NetworkException catch (exception) {
      _showErrorMessage(exception, onError);
    } on JsonFormatException catch (exception) {
      _showErrorMessage(exception, onError);
    } on NotFoundException catch (exception) {
      _showErrorMessage(exception, onError);
    } on ApiException catch (exception) {
      _showErrorMessage(exception, onError);
    } on AppException catch (exception) {
      _showErrorMessage(exception, onError);
    } catch (error, s) {
      _showErrorMessage(AppException(message: "$error"), onError);
      debugPrint("Controller>>>>>> error $s");
    }
  }

  _showErrorMessage(BaseException exception, onError) {
    _errorMessageController(exception.message);
    onError!(exception);
  }

  final RxString _messageController = ''.obs;

  final RxString _errorMessageController = ''.obs;

  final RxString _successMessageController = ''.obs;

  String get message => _messageController.value;

  String get errorMessage => _errorMessageController.value;

  String get successMessage => _messageController.value;

  showMessage(String msg) => _messageController(msg);

  showErrorMessage(String msg) => _errorMessageController(msg);

  showSuccessMessage(String msg) => _successMessageController(msg);

  void setRefreshController(RefreshController? refreshController) {
    _refreshController = refreshController ?? _refreshController;
  }

  void resetRefreshController<T>(RxList<T> dataList) {
    if (_refreshController.isRefresh) {
      dataList.clear();
      _refreshController.refreshCompleted();
    }
    if (_refreshController.isLoading) {
      _refreshController.loadComplete();
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  // void initSocket() {
  //   if (getToken() != null) {
  //     socket = getSocketInstance();
  //   }
  // }
  //
  // getSocketInstance() {
  //   return SocketService.instance.initSocket();
  // }

  @override
  void onClose() {
    _messageController.close();
    _refreshController.dispose();
    _pageSateController.close();
    super.onClose();
  }
}

class PageStateHandler {
  final ViewState viewState;
  final Function? onClickTryAgain;
  final String? message;
  final Widget? shimmerEffect;

  PageStateHandler(
      this.viewState, {
        this.onClickTryAgain,
        this.message,
        this.shimmerEffect,
      });
}
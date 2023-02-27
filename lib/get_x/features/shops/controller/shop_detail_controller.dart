import 'package:explore_places/get_x/constant/enum/view_state.dart';
import 'package:explore_places/get_x/core/base/base_controller.dart';
import 'package:explore_places/get_x/core/binding/view_controller_binding.dart';
import 'package:explore_places/get_x/core/utils/app_utils.dart';
import 'package:explore_places/get_x/core/utils/widget_helper.dart';
import 'package:explore_places/get_x/data_models/base_response/base_api_response.dart';
import 'package:explore_places/get_x/data_models/exception/base_exception.dart';
import 'package:explore_places/get_x/data_models/responses/shop_data_response.dart';
import 'package:explore_places/get_x/data_models/responses/shop_review_response.dart';
import 'package:explore_places/get_x/data_sources/network/shop/shop_repository.dart';
import 'package:explore_places/get_x/features/main_home/controller/main_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShopDetailController extends BaseController {
  ShopDataResponse? shopItem;

  late CameraPosition initialLocation;
  late Marker markers;
  RxBool isMapVisible = false.obs;
  RxBool isFavourite = false.obs;
  RxDouble mapHeightFactor = 0.2.obs;

  final ShopRepository _shopRepository = findInject(ShopRepository);

  final RxList<ShopReviewResponse> _reviewList = RxList.empty();

  List<ShopReviewResponse> get reviewList => _reviewList.obs.value;
  final MainHomeController mainHomeController = Get.find();

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) shopItem = Get.arguments;

    if(mainHomeController.isLogin.value){
      fetchShopReview();
    }
    isFavourite.value = shopItem?.isFavourite ?? false;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initShopLocation().then(
        (value) => Future.delayed(
          const Duration(milliseconds: 200),
          () {
            isMapVisible.value = true;
          },
        ),
      );
    });
  }

  void giveShopReview({required String comment, required double rating}) async {
    final _repoService = _shopRepository.giveReview(
        shopId: shopItem!.id!.toInt(), comment: comment, rate: rating.toInt());
    await callAPIService(
      _repoService,
      onStart: null,
      onSuccess: _handleGiveReviewResponseSuccess,
      onError: (BaseException exception) {
        AppUtils.showToast("Something went wrong. Please try again.");
      },
    );
  }

  void setFavourite() async {
    final _repoService = _shopRepository.setFavourite(
      shopId: shopItem!.id!.toInt(),
    );
    await callAPIService(
      _repoService,
      onStart: null,
      onSuccess: _handleSetFavResponseSuccess,
      onError: (BaseException exception) {
        AppUtils.showToast("Something went wrong. Please try again.");
      },
    );
  }

  void _handleSetFavResponseSuccess(response) async {
    isFavourite.value = !isFavourite.value;
  }

  void fetchShopReview() async {
    final _repoService = _shopRepository.getShoppReview(
        shopId: shopItem!.id!.toInt(), offset: 100);
    await callAPIService(
      _repoService,
      onStart: null,
      onSuccess: _handleShopReviewResponseSuccess,
      onError: _handleShopReviewResponseError,
    );
  }

  void _handleGiveReviewResponseSuccess(response) async {
    _reviewList.clear();
    fetchShopReview();
    AppUtils.showToast("Submitted");
    Get.back();
  }

  void _handleShopReviewResponseError(BaseException exception) {
    AppUtils.showToast(exception.message);
    return;
  }

  void _handleShopReviewResponseSuccess(response) async {
    if (response != null) {
      BaseApiResponse<ShopReviewResponse> shopData = response;
      List<ShopReviewResponse> data = shopData.listResult;
      _reviewList.addAll(data.toList());
      if (data.isEmpty) {
        Future.delayed(
          const Duration(seconds: 1),
          () => updatePageState(ViewState.EMPTYLIST,
              onClickTryAgain: () => {
                    fetchShopReview(),
                  }),
        );
      }
    }
  }

  onMapCreate(controller) {
    //controller.setMapStyle(mapStyles),
    Future.delayed(
      const Duration(milliseconds: 1200),
      () {
        isMapVisible.value = true;
      },
    );
  }

  Future<void> initShopLocation() async {
    initialLocation = CameraPosition(
      zoom: 13,
      bearing: 0,
      tilt: 0,
      target: LatLng(double.parse(shopItem?.latitude ?? "0.0"),
          double.parse(shopItem?.longitude ?? "0.0")),
    );

    await WidgetHelper().getBytesFromAsset('assets/shop_location.png', 86).then(
          (sourceIcon) => {
            markers = Marker(
              markerId: const MarkerId('ShopId'),
              position: LatLng(double.parse(shopItem?.latitude ?? "0.0"),
                  double.parse(shopItem?.longitude ?? "0.0")),
              icon: BitmapDescriptor.fromBytes(sourceIcon),
            )
          },
        );
  }
}

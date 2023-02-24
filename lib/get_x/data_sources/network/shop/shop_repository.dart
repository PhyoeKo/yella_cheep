import 'package:explore_places/get_x/data_models/responses/shop_data_response.dart';
import 'package:explore_places/get_x/data_models/responses/shop_profile_response.dart';
import 'package:explore_places/get_x/data_models/responses/shop_review_response.dart';

import '../../../data_models/base_response/base_api_response.dart';

abstract class ShopRepository {

  Future<BaseApiResponse<ShopDataResponse>> getNearByShopList(
      double lat, double long, double distance);

  Future<BaseApiResponse<ShopDataResponse>> getShopList(
      {int? offset = 100, int? categoryId, int? stateId,String? name});


  Future<BaseApiResponse<ShopReviewResponse>> getShoppReview(
      {int? offset, required int shopId});

  Future<BaseApiResponse<String?>> giveReview(
      {required int shopId, required String comment, required int rate});

  Future<BaseApiResponse<String?>> setFavourite(
      {required int shopId});
}

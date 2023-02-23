import 'package:dio/dio.dart';
import 'package:explore_places/get_x/core/base/base_remote_source.dart';
import 'package:explore_places/get_x/core/services/dio_provider.dart';
import 'package:explore_places/get_x/data_models/base_response/base_api_response.dart';
import 'package:explore_places/get_x/data_models/pagination/pagination_ob.dart';
import 'package:explore_places/get_x/data_models/responses/shop_profile_response.dart';
import 'package:explore_places/get_x/data_models/responses/shop_review_response.dart';
import 'package:explore_places/get_x/data_sources/network/shop/shop_repository.dart';

class ShopRepositoryImpl extends BaseRemoteSource implements ShopRepository {
  var endpoint = DioProvider.baseUrl;

  @override
  Future<BaseApiResponse<ShopReviewResponse>> getShoppReview(
      {int? offset, required int shopId}) {
    var dioCall = dioClient
        .get("$endpoint/api/shop-review-list?offset=$offset&shop_id=$shopId");
    try {
      return callApiWithErrorParser(dioCall).then(
        (response) => _parseShopReviewResponse(response),
      );
    } catch (e) {
      rethrow;
    }
  }

  BaseApiResponse<ShopReviewResponse> _parseShopReviewResponse(
      Response response) {
    return BaseApiResponse<ShopReviewResponse>.fromListJsonWithPagination(
        response.data,
        create: (data) => ShopReviewResponse.fromJson(data),
        createLinkObject: (linkData) => Links.fromJson(linkData),
        createMetaObject: (metaData) => Meta.fromJson(metaData));
  }

  @override
  Future<BaseApiResponse<String?>> giveReview(
      {required int shopId, required String comment, required int rate}) {
    var dioCall = dioClient.post("$endpoint/api/shop-review",
        data: {"shop_id": shopId, "comment": comment, "rate": rate});
    try {
      return callApiWithErrorParser(dioCall).then(
        (response) => _parseGiveReviewResponse(response),
      );
    } catch (e) {
      rethrow;
    }
  }

  BaseApiResponse<String?> _parseGiveReviewResponse(Response response) {
    return BaseApiResponse<String?>.fromStringJson(response.data);
  }

  @override
  Future<BaseApiResponse<String?>> setFavourite({required int shopId}) {
    var dioCall = dioClient.post("$endpoint/api/shop-favourite",
        data: {"shop_id": shopId});
    try {
      return callApiWithErrorParser(dioCall).then(
            (response) => _parseGiveReviewResponse(response),
      );
    } catch (e) {
      rethrow;
    }
  }
}

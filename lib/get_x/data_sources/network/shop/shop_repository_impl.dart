import 'package:dio/dio.dart';
import 'package:explore_places/get_x/core/base/base_remote_source.dart';
import 'package:explore_places/get_x/core/services/dio_provider.dart';
import 'package:explore_places/get_x/data_models/base_response/base_api_response.dart';
import 'package:explore_places/get_x/data_models/responses/shop_profile_response.dart';
import 'package:explore_places/get_x/data_sources/network/shop/shop_repository.dart';


class ShopRepositoryImpl extends BaseRemoteSource implements ShopRepository {
  var endpoint = DioProvider.baseUrl;

  @override
  Future<BaseApiResponse<ShopProfileResponse>> getShopProfile() {
    var dioCall = dioClient.get("$endpoint/api/shop-profile");
    try {
      return callApiWithErrorParser(dioCall).then(
        (response) => _parseShopProfileResponse(response),
      );
    } catch (e) {
      rethrow;
    }
  }

  BaseApiResponse<ShopProfileResponse> _parseShopProfileResponse(
      Response response) {
    return BaseApiResponse<ShopProfileResponse>.fromObjectJson(response.data,
        createObject: (data) => ShopProfileResponse.fromJson(data));
  }
}

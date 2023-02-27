import 'package:dio/dio.dart';
import 'package:explore_places/get_x/core/base/base_remote_source.dart';
import 'package:explore_places/get_x/core/services/dio_provider.dart';
import 'package:explore_places/get_x/data_models/base_response/base_api_response.dart';
import 'package:explore_places/get_x/data_models/pagination/pagination_ob.dart';
import 'package:explore_places/get_x/data_models/responses/favourite_shop_list.dart';
import 'package:explore_places/get_x/data_sources/network/favourite/favourite_repository.dart';

class FavouriteRepositoryImpl extends BaseRemoteSource
    implements FavouriteRepository {
  @override
  Future<BaseApiResponse<FavouriteShopData>> getFavouriteList() async {
    var endpoint = DioProvider.baseUrl;

    var dioCall =
        dioClient.get("$endpoint/api/shop-favourite-list?offset=100&shop_id=");
    try {
      return callApiWithErrorParser(dioCall).then(
        (response) => _parseFavListResponse(response),
      );
    } catch (e) {
      rethrow;
    }
  }

  BaseApiResponse<FavouriteShopData> _parseFavListResponse(Response response) {
    return BaseApiResponse<FavouriteShopData>.fromListJsonWithPagination(
        response.data,
        create: (data) => FavouriteShopData.fromJson(data),
        createLinkObject: (linkData) => Links.fromJson(linkData),
        createMetaObject: (metaData) => Meta.fromJson(metaData));
  }
}

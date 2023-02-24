import 'package:dio/dio.dart';
import 'package:explore_places/get_x/core/base/base_remote_source.dart';
import 'package:explore_places/get_x/core/services/dio_provider.dart';
import 'package:explore_places/get_x/data_models/base_response/base_api_response.dart';
import 'package:explore_places/get_x/data_models/responses/banner_response.dart';
import 'package:explore_places/get_x/data_models/responses/dummy_list_response.dart';
import 'package:explore_places/get_x/data_models/responses/shop_data_response.dart';
import 'package:explore_places/get_x/data_models/view_object/setup_vo.dart';
import 'package:explore_places/get_x/data_sources/network/home/home_repository.dart';
import 'package:explore_places/get_x/data_sources/network/sample_feature/sample_repository.dart';

class HomeRepositoryImpl extends BaseRemoteSource implements HomeRepository {
  var endpoint = DioProvider.baseUrl;

  @override
  Future<BaseApiResponse<BannerResponse>> getBannerData() {
    var dioCall = dioClient.get("$endpoint/api/banner-list");
    try {
      return callApiWithErrorParser(dioCall).then(
        (response) => _parseBannerListResponse(response),
      );
    } catch (e) {
      rethrow;
    }
  }

  BaseApiResponse<BannerResponse> _parseBannerListResponse(Response response) {
    return BaseApiResponse<BannerResponse>.fromListJson(response.data,
        createList: (data) => BannerResponse.fromJson(data));
  }

  @override
  Future<BaseApiResponse<SetUpVo>> getCategoryList() {
    var dioCall = dioClient.get("$endpoint/api/category-list");
    try {
      return callApiWithErrorParser(dioCall).then(
        (response) => _parseCategoryListResponse(response),
      );
    } catch (e) {
      rethrow;
    }
  }

  BaseApiResponse<SetUpVo> _parseCategoryListResponse(Response response) {
    return BaseApiResponse<SetUpVo>.fromListJson(response.data,
        createList: (data) => SetUpVo.fromJson(data));
  }



  @override
  Future<BaseApiResponse<SetUpVo>> getStateList() {
    var dioCall = dioClient.get("$endpoint/api/state-list");
    try {
      return callApiWithErrorParser(dioCall).then(
        (response) => _parseCategoryListResponse(response),
      );
    } catch (e) {
      rethrow;
    }
  }


}

/// https://api.yalla.cheap/storage/banner/261676964567.jpeg

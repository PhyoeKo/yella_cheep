import 'package:dio/dio.dart';
import 'package:explore_places/get_x/core/base/base_remote_source.dart';
import 'package:explore_places/get_x/data_models/base_response/base_api_response.dart';
import 'package:explore_places/get_x/data_models/responses/dummy_list_response.dart';
import 'package:explore_places/get_x/data_sources/network/sample_feature/sample_repository.dart';


class SampleRepositoryImpl extends BaseRemoteSource
    implements SampleRepository {
  @override
  Future<BaseApiResponse<DummyListResponse>> getDummyData() async {
    var endpoint = "https://api.npoint.io/384501a2494f64a6846e";
    var dioCall = dioClient.get(endpoint);
    try {
      return callApiWithErrorParser(dioCall).then(
        (response) => _parseBannerResponse(response),
      );
    } catch (e) {
      rethrow;
    }
  }

  BaseApiResponse<DummyListResponse> _parseBannerResponse(Response response) {
    return BaseApiResponse<DummyListResponse>.fromObjectJson(response.data,
        createObject: (data) => DummyListResponse.fromJson(data));
  }
}

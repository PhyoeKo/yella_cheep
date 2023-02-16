import 'package:dio/dio.dart';
import 'package:explore_places/get_x/core/base/base_remote_source.dart';
import 'package:explore_places/get_x/core/services/dio_provider.dart';
import 'package:explore_places/get_x/data_models/base_response/base_api_response.dart';
import 'package:explore_places/get_x/data_models/request_ob/profile_update_request_ob.dart';
import 'package:explore_places/get_x/data_models/responses/merchant_profile_response.dart';
import 'package:explore_places/get_x/data_sources/network/profile/profile_repository.dart';



class ProfileRepositoryImpl extends BaseRemoteSource
    implements ProfileRepository {
  var endpoint = DioProvider.baseUrl;

  @override
  Future<BaseApiResponse<MerchantProfileResponse>> getMerchantProfile() {
    var dioCall = dioClient.get("$endpoint/api/merchant-profile");
    try {
      return callApiWithErrorParser(dioCall).then(
        (response) => _parseMerchantProfileResponse(response),
      );
    } catch (e) {
      rethrow;
    }
  }

  BaseApiResponse<MerchantProfileResponse> _parseMerchantProfileResponse(
      Response response) {
    return BaseApiResponse<MerchantProfileResponse>.fromObjectJson(response.data,
        createObject: (data) => MerchantProfileResponse.fromJson(data));
  }

  @override
  Future<BaseApiResponse<MerchantProfileResponse?>> updateProfile(
      ProfileUpdateRequestOb profileUpdateRequestOb) {
    try {
      return callApiWithErrorParser(dioClient.post(
              "$endpoint/api/merchant-profile-update",
              data: profileUpdateRequestOb.toJson()))
          .then((response) => _parseMerchantProfileResponse(response));
    } catch (e) {
      rethrow;
    }
  }


}

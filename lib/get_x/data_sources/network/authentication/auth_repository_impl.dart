import 'package:dio/dio.dart';
import 'package:explore_places/get_x/core/base/base_remote_source.dart';
import 'package:explore_places/get_x/core/services/dio_provider.dart';
import 'package:explore_places/get_x/data_models/base_response/base_api_response.dart';
import 'package:explore_places/get_x/data_models/request_ob/firebase_token_request_ob.dart';
import 'package:explore_places/get_x/data_models/request_ob/login_request_ob.dart';
import 'package:explore_places/get_x/data_models/request_ob/register_request_ob.dart';
import 'package:explore_places/get_x/data_models/responses/profile/profile_response.dart';

import 'auth_repository.dart';

class AuthRepositoryImpl extends BaseRemoteSource implements AuthRepository {
  @override
  Future<BaseApiResponse<ProfileResponse>> loginUser(
      LoginRequestOb loginRequestOb) {
    var endpoint = "${DioProvider.baseUrl}/api/user-login";

    var dioCall = dioClient.post(endpoint, data: loginRequestOb.toJson());
    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseLoginResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  BaseApiResponse<ProfileResponse> _parseLoginResponse(Response response) {
    return BaseApiResponse<ProfileResponse>.fromObjectJson(response.data,
        createObject: (data) => ProfileResponse.fromJson(data));
  }

  //UpdateFirebaseToken
  @override
  Future<BaseApiResponse<String?>> updateFirebaseToken(
      FirebaseTokenRequestOb firebaseTokenRequestOb) {
    try {
      return callApiWithErrorParser(dioClient.post(
              "${DioProvider.baseUrl}/merchant/firebase-token-update",
              data: firebaseTokenRequestOb.toJson()))
          .then((response) => BaseApiResponse<String?>.fromStringJson(
                response.data,
              ));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BaseApiResponse<ProfileResponse>> registerUser(
      RegisterRequestOb registerRequestOb) {
    var endpoint = "${DioProvider.baseUrl}/api/user-register";

    var dioCall = dioClient.post(endpoint, data: registerRequestOb.toJson());
    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseLoginResponse(response));
    } catch (e) {
      rethrow;
    }
  }
}

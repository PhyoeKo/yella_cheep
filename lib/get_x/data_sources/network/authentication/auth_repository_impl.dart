import 'package:dio/dio.dart';
import 'package:yella_merchant/core/base/base_remote_source.dart';
import 'package:yella_merchant/core/services/dio_provider.dart';
import 'package:yella_merchant/data_models/base_response/base_api_response.dart';
import 'package:yella_merchant/data_models/request_ob/firebase_token_request_ob.dart';
import 'package:yella_merchant/data_models/request_ob/login_request_ob.dart';
import 'package:yella_merchant/data_models/responses/login_response.dart';

import 'auth_repository.dart';

class AuthRepositoryImpl extends BaseRemoteSource implements AuthRepository {
  @override
  Future<BaseApiResponse<LoginResponse>> loginUser(
      LoginRequestOb loginRequestOb) {
    var endpoint = "${DioProvider.baseUrl}/api/merchant-login";

    var dioCall = dioClient.post(endpoint, data: loginRequestOb.toJson());
    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseLoginResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  BaseApiResponse<LoginResponse> _parseLoginResponse(Response response) {
    return BaseApiResponse<LoginResponse>.fromObjectJson(response.data,
        createObject: (data) => LoginResponse.fromJson(data));
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
}

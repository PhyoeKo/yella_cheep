import 'package:explore_places/get_x/data_models/base_response/base_api_response.dart';
import 'package:explore_places/get_x/data_models/request_ob/login_request_ob.dart';
import 'package:explore_places/get_x/data_models/request_ob/register_request_ob.dart';
import 'package:explore_places/get_x/data_models/responses/profile/profile_response.dart';

import '../../../data_models/request_ob/firebase_token_request_ob.dart';

abstract class AuthRepository {
  //Local
  Future<BaseApiResponse<ProfileResponse>> loginUser(
      LoginRequestOb loginRequestOb);

  Future<BaseApiResponse<ProfileResponse>> registerUser(
      RegisterRequestOb registerRequestOb);

  //UpdateFirebaseToken
  Future<BaseApiResponse<String?>> updateFirebaseToken(
      FirebaseTokenRequestOb firebaseTokenRequestOb);
}

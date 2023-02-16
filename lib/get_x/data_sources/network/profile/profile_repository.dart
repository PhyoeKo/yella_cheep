


import 'package:explore_places/get_x/data_models/base_response/base_api_response.dart';
import 'package:explore_places/get_x/data_models/request_ob/profile_update_request_ob.dart';
import 'package:explore_places/get_x/data_models/responses/merchant_profile_response.dart';

abstract class ProfileRepository {
  //Local
  Future<BaseApiResponse<MerchantProfileResponse>> getMerchantProfile();

  //Update Profile
  Future<BaseApiResponse<MerchantProfileResponse?>> updateProfile(
      ProfileUpdateRequestOb profileUpdateRequestOb);
}

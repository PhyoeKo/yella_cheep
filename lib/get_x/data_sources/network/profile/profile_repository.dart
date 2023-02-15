

import 'package:yella_merchant/data_models/base_response/base_api_response.dart';
import 'package:yella_merchant/data_models/request_ob/profile_update_request_ob.dart';
import 'package:yella_merchant/data_models/responses/merchant_profile_response.dart';


abstract class ProfileRepository {
  //Local
  Future<BaseApiResponse<MerchantProfileResponse>> getMerchantProfile();

  //Update Profile
  Future<BaseApiResponse<MerchantProfileResponse?>> updateProfile(
      ProfileUpdateRequestOb profileUpdateRequestOb);
}

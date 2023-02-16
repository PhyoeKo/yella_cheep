


import 'package:explore_places/get_x/data_models/responses/shop_profile_response.dart';

import '../../../data_models/base_response/base_api_response.dart';

abstract class ShopRepository {
  Future<BaseApiResponse<ShopProfileResponse>> getShopProfile();

}

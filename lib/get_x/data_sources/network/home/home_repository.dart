


import 'package:explore_places/get_x/data_models/base_response/base_api_response.dart';
import 'package:explore_places/get_x/data_models/responses/banner_response.dart';
import 'package:explore_places/get_x/data_models/view_object/setup_vo.dart';

abstract class HomeRepository {
  Future<BaseApiResponse<BannerResponse>> getBannerData();
  Future<BaseApiResponse<SetUpVo>> getCategoryList();
}

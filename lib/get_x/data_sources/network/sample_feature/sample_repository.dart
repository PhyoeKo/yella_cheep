


import 'package:explore_places/get_x/data_models/base_response/base_api_response.dart';
import 'package:explore_places/get_x/data_models/responses/dummy_list_response.dart';

abstract class SampleRepository {
  Future<BaseApiResponse<DummyListResponse>> getDummyData();
}

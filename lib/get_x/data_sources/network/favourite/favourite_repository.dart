


import 'package:explore_places/get_x/data_models/base_response/base_api_response.dart';
import 'package:explore_places/get_x/data_models/responses/dummy_list_response.dart';
import 'package:explore_places/get_x/data_models/responses/favourite_shop_list.dart';
import 'package:explore_places/get_x/data_models/responses/shop_data_response.dart';

abstract class FavouriteRepository {
  Future<BaseApiResponse<FavouriteShopData>> getFavouriteList();
}
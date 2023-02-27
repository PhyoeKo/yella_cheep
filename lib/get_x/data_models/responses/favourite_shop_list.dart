
import 'package:explore_places/get_x/data_models/responses/shop_data_response.dart';

class FavouriteShopData {
  int? id;
  ShopDataResponse? shop;
  String? shopName;
  String? date;

  FavouriteShopData({
      this.id, 
      this.shop, 
      this.shopName, 
      this.date});

  FavouriteShopData.fromJson(dynamic json) {
    id = json["id"];
    shop = json["shop"] != null ? ShopDataResponse.fromJson(json["shop"]) : null;
    shopName = json["shopName"];
    date = json["date"];
  }

}

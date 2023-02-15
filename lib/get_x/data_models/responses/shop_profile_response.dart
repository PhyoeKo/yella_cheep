
class ShopProfileResponse {
  String? category;
  String? state;
  int? shopId;
  String? phone;
  String? name;
  String? email;
  String? website;
  String? latitude;
  String? longitude;
  String? attractions;
  String? description;
  String? price;
  String? discount;
  String? image1;
  String? image2;
  int? status;

  ShopProfileResponse({
      this.category, 
      this.state, 
      this.shopId, 
      this.phone, 
      this.name, 
      this.email, 
      this.website, 
      this.latitude, 
      this.longitude, 
      this.attractions, 
      this.description, 
      this.price, 
      this.discount, 
      this.image1, 
      this.image2, 
      this.status});

  ShopProfileResponse.fromJson(dynamic json) {
    category = json["category"];
    state = json["state"];
    shopId = json["shopId"];
    phone = json["phone"];
    name = json["name"];
    email = json["email"];
    website = json["website"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    attractions = json["attractions"];
    description = json["description"];
    price = json["price"];
    discount = json["discount"];
    image1 = json["image1"];
    image2 = json["image2"];
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["category"] = category;
    map["state"] = state;
    map["shopId"] = shopId;
    map["phone"] = phone;
    map["name"] = name;
    map["email"] = email;
    map["website"] = website;
    map["latitude"] = latitude;
    map["longitude"] = longitude;
    map["attractions"] = attractions;
    map["description"] = description;
    map["price"] = price;
    map["discount"] = discount;
    map["image1"] = image1;
    map["image2"] = image2;
    map["status"] = status;
    return map;
  }

}

class LoginResponse {
  String? token;
  int? id;
  String? name;
  String? phone;
  String? image;
  String? role;
  int? shopId;
  String? shop;

  LoginResponse({
    this.token,
    this.id,
    this.name,
    this.phone,
    this.image,
    this.role,
    this.shopId,
    this.shop});

  LoginResponse.fromJson(dynamic json) {
    token = json["token"];
    id = json["id"];
    name = json["name"];
    phone = json["phone"];
    image = json["image"];
    role = json["role"];
    shopId = json["shopId"];
    shop = json["shop"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["token"] = token;
    map["id"] = id;
    map["name"] = name;
    map["phone"] = phone;
    map["image"] = image;
    map["role"] = role;
    map["shopId"] = shopId;
    map["shop"] = shop;
    return map;
  }

}
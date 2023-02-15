/// data : {"name":"BeerFactory's Merchant","phone":"0911111111","image":"/storage/merchant/891676351457.png","role":"merchant","category":"Restaurant","state":"Yangon","shopId":1,"shopPhone":"09782672122","shopName":"The Beer Factory Yangon","shopEmail":"info@connexg.com","website":"www.beerfactory.com","latitude":"16.8093073","longitude":"96.148947","attractions":"🍝 Elevate your lunch game with our “Day Drinking” cocktail selection.🍹\nWith cocktails we've picked out just for you, your lunch is now guaranteed to be spectacular like never before. 🤤","description":"The Beer Factory & Attic team wishes this new year bring you new possibilities, new horizons and new joys. Gather together with your loved ones and come celebrate the New Year with us.🏮May the good fortune shine on you. ✨\nGōng xǐ fā cái 🧧","price":null,"discount":"20","image1":"/storage/shop/91676351357.jpeg","image2":"/storage/shop/781676351357.jpeg","status":1}
/// status : true
/// message : "Success get merchant profile"
/// error : []


class MerchantProfileResponse {
  MerchantProfileResponse({
      this.name, 
      this.phone, 
      this.image, 
      this.role, 
      this.category, 
      this.state, 
      this.shopId, 
      this.shopPhone, 
      this.shopName, 
      this.shopEmail, 
      this.website, 
      this.latitude, 
      this.longitude, 
      this.attractions, 
      this.description, 
      this.price, 
      this.discount, 
      this.image1, 
      this.image2, 
      this.status,});

  MerchantProfileResponse.fromJson(dynamic json) {
    name = json['name'];
    phone = json['phone'];
    image = json['image'];
    role = json['role'];
    category = json['category'];
    state = json['state'];
    shopId = json['shopId'];
    shopPhone = json['shopPhone'];
    shopName = json['shopName'];
    shopEmail = json['shopEmail'];
    website = json['website'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    attractions = json['attractions'];
    description = json['description'];
    price = json['price'];
    discount = json['discount'];
    image1 = json['image1'];
    image2 = json['image2'];
    status = json['status'];
  }
  String? name;
  String? phone;
  String? image;
  String? role;
  String? category;
  String? state;
  num? shopId;
  String? shopPhone;
  String? shopName;
  String? shopEmail;
  String? website;
  String? latitude;
  String? longitude;
  String? attractions;
  String? description;
  dynamic price;
  String? discount;
  String? image1;
  String? image2;
  num? status;
  MerchantProfileResponse copyWith({  String? name,
  String? phone,
  String? image,
  String? role,
  String? category,
  String? state,
  num? shopId,
  String? shopPhone,
  String? shopName,
  String? shopEmail,
  String? website,
  String? latitude,
  String? longitude,
  String? attractions,
  String? description,
  dynamic price,
  String? discount,
  String? image1,
  String? image2,
  num? status,
}) => MerchantProfileResponse(  name: name ?? this.name,
  phone: phone ?? this.phone,
  image: image ?? this.image,
  role: role ?? this.role,
  category: category ?? this.category,
  state: state ?? this.state,
  shopId: shopId ?? this.shopId,
  shopPhone: shopPhone ?? this.shopPhone,
  shopName: shopName ?? this.shopName,
  shopEmail: shopEmail ?? this.shopEmail,
  website: website ?? this.website,
  latitude: latitude ?? this.latitude,
  longitude: longitude ?? this.longitude,
  attractions: attractions ?? this.attractions,
  description: description ?? this.description,
  price: price ?? this.price,
  discount: discount ?? this.discount,
  image1: image1 ?? this.image1,
  image2: image2 ?? this.image2,
  status: status ?? this.status,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['phone'] = phone;
    map['image'] = image;
    map['role'] = role;
    map['category'] = category;
    map['state'] = state;
    map['shopId'] = shopId;
    map['shopPhone'] = shopPhone;
    map['shopName'] = shopName;
    map['shopEmail'] = shopEmail;
    map['website'] = website;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['attractions'] = attractions;
    map['description'] = description;
    map['price'] = price;
    map['discount'] = discount;
    map['image1'] = image1;
    map['image2'] = image2;
    map['status'] = status;
    return map;
  }

}
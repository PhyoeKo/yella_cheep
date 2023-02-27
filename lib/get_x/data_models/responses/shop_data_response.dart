class ShopDataResponse {
  ShopDataResponse({
    this.id,
    this.category,
    this.state,
    this.name,
    this.phone,
    this.email,
    this.website,
    this.attractions,
    this.description,
    this.price,
    this.discount,
    this.latitude,
    this.longitude,
    this.status,
    this.image1,
    this.distance,
    this.gallery,
    this.rating,
    this.reviewCount,
  });

  ShopDataResponse.fromJson(dynamic json) {
    id = json['id'];
    category = json['category'];
    state = json['state'];
    isFavourite = json['favourite']??false;
    name = json['name'];
    phone = json['phone'];
    distance = json['distance'] != null
        ? double.parse(json['distance'].toStringAsFixed(3))
        : null;
    email = json['email'];
    website = json['website'];
    attractions = json['attractions'];
    description = json['description'];
    price = json['price'];
    discount = json['discount'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    status = json['status'];
    image1 = json['image1'];
    gallery = json['gallery'] != null ? json['gallery'].cast<String>() : [];
    rating = json['rating'];
    reviewCount = json['reviewCount'];
  }

  num? id;
  String? category;
  String? state;
  String? name;
  String? phone;
  String? email;
  String? website;
  String? attractions;
  String? description;
  String? price;
  String? discount;
  dynamic latitude;
  dynamic longitude;
  bool? isFavourite;
  num? status;
  double? distance;
  String? image1;
  List<String>? gallery;
  num? rating;
  num? reviewCount;

  ShopDataResponse copyWith({
    num? id,
    String? category,
    String? state,
    String? name,
    bool? isFavourite,
    String? phone,
    String? email,
    String? website,
    String? attractions,
    String? description,
    String? price,
    String? discount,
    String? latitude,
    String? longitude,
    num? status,
    String? image1,
    List<String>? gallery,
    num? rating,
    num? reviewCount,
  }) =>
      ShopDataResponse(
        id: id ?? this.id,
        category: category ?? this.category,
        state: state ?? this.state,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        website: website ?? this.website,
        attractions: attractions ?? this.attractions,
        description: description ?? this.description,
        price: price ?? this.price,
        discount: discount ?? this.discount,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        status: status ?? this.status,
        image1: image1 ?? this.image1,
        gallery: gallery ?? this.gallery,
        rating: rating ?? this.rating,
        reviewCount: reviewCount ?? this.reviewCount,
      );
}

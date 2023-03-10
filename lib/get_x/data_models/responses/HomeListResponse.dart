
class HomeListResponse {
  HomeListResponse({
      this.id, 
      this.name, 
      this.image, 
      this.homeStatus, 
      this.status, 
      this.deletedAt, 
      this.createdAt, 
      this.updatedAt, 
      this.shop,});

  HomeListResponse.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    homeStatus = json['home_status'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['shop'] != null) {
      shop = [];
      json['shop'].forEach((v) {
        shop?.add(Shop.fromJson(v));
      });
    }
  }
  num? id;
  String? name;
  String? image;
  num? homeStatus;
  num? status;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  List<Shop>? shop;
  HomeListResponse copyWith({  num? id,
  String? name,
  String? image,
  num? homeStatus,
  num? status,
  dynamic deletedAt,
  String? createdAt,
  String? updatedAt,
  List<Shop>? shop,
}) => HomeListResponse(  id: id ?? this.id,
  name: name ?? this.name,
  image: image ?? this.image,
  homeStatus: homeStatus ?? this.homeStatus,
  status: status ?? this.status,
  deletedAt: deletedAt ?? this.deletedAt,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  shop: shop ?? this.shop,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['home_status'] = homeStatus;
    map['status'] = status;
    map['deleted_at'] = deletedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (shop != null) {
      map['shop'] = shop?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Shop {
  Shop({
      this.id,
      this.stateId,
      this.categoryId,
      this.name,
      this.qr,
      this.website,
      this.email,
      this.phone,
      this.attractions,
      this.description,
      this.price,
      this.discount,
      this.latitude,
      this.longitude,
      this.image1,
      this.image2,
      this.status,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.rating,
      this.reviewCount,
      this.gallery,
      this.category,
      this.state,});

  Shop.fromJson(dynamic json) {
    id = json['id'];
    stateId = json['state_id'];
    categoryId = json['category_id'];
    name = json['name'];
    qr = json['qr'];
    website = json['website'];
    email = json['email'];
    phone = json['phone'];
    attractions = json['attractions'];
    description = json['description'];
    price = json['price'];
    discount = json['discount'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    image1 = json['image1'];
    image2 = json['image2'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    rating = json['rating'];
    reviewCount = json['reviewCount'];
    gallery = json['gallery'] != null ? json['gallery'].cast<String>() : [];
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
    state = json['state'] != null ? State.fromJson(json['state']) : null;
  }
  num? id;
  num? stateId;
  num? categoryId;
  String? name;
  dynamic qr;
  String? website;
  String? email;
  String? phone;
  String? attractions;
  String? description;
  dynamic price;
  String? discount;
  String? latitude;
  String? longitude;
  String? image1;
  String? image2;
  num? status;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  dynamic rating;
  num? reviewCount;
  List<String>? gallery;
  Category? category;
  State? state;
Shop copyWith({  num? id,
  num? stateId,
  num? categoryId,
  String? name,
  dynamic qr,
  String? website,
  String? email,
  String? phone,
  String? attractions,
  String? description,
  dynamic price,
  String? discount,
  String? latitude,
  String? longitude,
  String? image1,
  String? image2,
  num? status,
  dynamic deletedAt,
  String? createdAt,
  String? updatedAt,
  String? rating,
  num? reviewCount,
  List<String>? gallery,
  Category? category,
  State? state,
}) => Shop(  id: id ?? this.id,
  stateId: stateId ?? this.stateId,
  categoryId: categoryId ?? this.categoryId,
  name: name ?? this.name,
  qr: qr ?? this.qr,
  website: website ?? this.website,
  email: email ?? this.email,
  phone: phone ?? this.phone,
  attractions: attractions ?? this.attractions,
  description: description ?? this.description,
  price: price ?? this.price,
  discount: discount ?? this.discount,
  latitude: latitude ?? this.latitude,
  longitude: longitude ?? this.longitude,
  image1: image1 ?? this.image1,
  image2: image2 ?? this.image2,
  status: status ?? this.status,
  deletedAt: deletedAt ?? this.deletedAt,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  rating: rating ?? this.rating,
  reviewCount: reviewCount ?? this.reviewCount,
  gallery: gallery ?? this.gallery,
  category: category ?? this.category,
  state: state ?? this.state,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['state_id'] = stateId;
    map['category_id'] = categoryId;
    map['name'] = name;
    map['qr'] = qr;
    map['website'] = website;
    map['email'] = email;
    map['phone'] = phone;
    map['attractions'] = attractions;
    map['description'] = description;
    map['price'] = price;
    map['discount'] = discount;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['image1'] = image1;
    map['image2'] = image2;
    map['status'] = status;
    map['deleted_at'] = deletedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['rating'] = rating;
    map['reviewCount'] = reviewCount;
    map['gallery'] = gallery;
    if (category != null) {
      map['category'] = category?.toJson();
    }
    if (state != null) {
      map['state'] = state?.toJson();
    }
    return map;
  }

}

class State {
  State({
      this.id, 
      this.name, 
      this.image, 
      this.status, 
      this.deletedAt, 
      this.createdAt, 
      this.updatedAt,});

  State.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? name;
  String? image;
  num? status;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
State copyWith({  num? id,
  String? name,
  String? image,
  num? status,
  dynamic deletedAt,
  String? createdAt,
  String? updatedAt,
}) => State(  id: id ?? this.id,
  name: name ?? this.name,
  image: image ?? this.image,
  status: status ?? this.status,
  deletedAt: deletedAt ?? this.deletedAt,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['status'] = status;
    map['deleted_at'] = deletedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}

class Category {
  Category({
      this.id, 
      this.name, 
      this.image, 
      this.homeStatus, 
      this.status, 
      this.deletedAt, 
      this.createdAt, 
      this.updatedAt,});

  Category.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    homeStatus = json['home_status'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? name;
  String? image;
  num? homeStatus;
  num? status;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
Category copyWith({  num? id,
  String? name,
  String? image,
  num? homeStatus,
  num? status,
  dynamic deletedAt,
  String? createdAt,
  String? updatedAt,
}) => Category(  id: id ?? this.id,
  name: name ?? this.name,
  image: image ?? this.image,
  homeStatus: homeStatus ?? this.homeStatus,
  status: status ?? this.status,
  deletedAt: deletedAt ?? this.deletedAt,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['home_status'] = homeStatus;
    map['status'] = status;
    map['deleted_at'] = deletedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}
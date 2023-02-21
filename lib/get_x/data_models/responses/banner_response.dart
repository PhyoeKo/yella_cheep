/// data : [{"id":1,"image":"/storage/banner/11676592117.png","banner_detail":[{"id":1,"banner_id":1,"type":"text","description":"<p>Hello World</p>","sort":"2023-02-17","deleted_at":null,"created_at":"2023-02-17T00:02:11.000000Z","updated_at":"2023-02-17T00:02:11.000000Z"},{"id":2,"banner_id":1,"type":"image","description":"/storage/bannerdetail/851676592141.png","sort":"2023-02-17","deleted_at":null,"created_at":"2023-02-17T00:02:21.000000Z","updated_at":"2023-02-17T00:02:21.000000Z"}]}]
/// status : true
/// message : ""
/// error : []

/// image : "/storage/banner/11676592117.png"
/// banner_detail : [{"id":1,"banner_id":1,"type":"text","description":"<p>Hello World</p>","sort":"2023-02-17","deleted_at":null,"created_at":"2023-02-17T00:02:11.000000Z","updated_at":"2023-02-17T00:02:11.000000Z"},{"id":2,"banner_id":1,"type":"image","description":"/storage/bannerdetail/851676592141.png","sort":"2023-02-17","deleted_at":null,"created_at":"2023-02-17T00:02:21.000000Z","updated_at":"2023-02-17T00:02:21.000000Z"}]

class BannerResponse {
  BannerResponse({
    this.id,
    this.image,
    this.bannerDetail,
  });

  BannerResponse.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
    if (json['banner_detail'] != null) {
      bannerDetail = [];
      json['banner_detail'].forEach((v) {
        bannerDetail?.add(BannerDetail.fromJson(v));
      });
    }
  }

  num? id;
  String? image;
  List<BannerDetail>? bannerDetail;

  BannerResponse copyWith({
    num? id,
    String? image,
    List<BannerDetail>? bannerDetail,
  }) =>
      BannerResponse(
        id: id ?? this.id,
        image: image ?? this.image,
        bannerDetail: bannerDetail ?? this.bannerDetail,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    if (bannerDetail != null) {
      map['banner_detail'] = bannerDetail?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// banner_id : 1
/// type : "text"
/// description : "<p>Hello World</p>"
/// sort : "2023-02-17"
/// deleted_at : null
/// created_at : "2023-02-17T00:02:11.000000Z"
/// updated_at : "2023-02-17T00:02:11.000000Z"

class BannerDetail {
  BannerDetail({
    this.id,
    this.bannerId,
    this.type,
    this.description,
    this.sort,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  BannerDetail.fromJson(dynamic json) {
    id = json['id'];
    bannerId = json['banner_id'];
    type = json['type'];
    description = json['description'];
    sort = json['sort'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  num? id;
  num? bannerId;
  String? type;
  String? description;
  String? sort;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;

  BannerDetail copyWith({
    num? id,
    num? bannerId,
    String? type,
    String? description,
    String? sort,
    dynamic deletedAt,
    String? createdAt,
    String? updatedAt,
  }) =>
      BannerDetail(
        id: id ?? this.id,
        bannerId: bannerId ?? this.bannerId,
        type: type ?? this.type,
        description: description ?? this.description,
        sort: sort ?? this.sort,
        deletedAt: deletedAt ?? this.deletedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['banner_id'] = bannerId;
    map['type'] = type;
    map['description'] = description;
    map['sort'] = sort;
    map['deleted_at'] = deletedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}


class ShopReviewResponse {
  ShopReviewResponse({
      this.id, 
      this.name, 
      this.image, 
      this.rating, 
      this.comment, 
      this.date,});

  ShopReviewResponse.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    rating = json['rating'];
    comment = json['comment'];
    date = json['date'];
  }
  num? id;
  String? name;
  dynamic image;
  num? rating;
  String? comment;
  String? date;
  ShopReviewResponse copyWith({  num? id,
  String? name,
  dynamic image,
  num? rating,
  String? comment,
  String? date,
}) => ShopReviewResponse(  id: id ?? this.id,
  name: name ?? this.name,
  image: image ?? this.image,
  rating: rating ?? this.rating,
  comment: comment ?? this.comment,
  date: date ?? this.date,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['rating'] = rating;
    map['comment'] = comment;
    map['date'] = date;
    return map;
  }

}
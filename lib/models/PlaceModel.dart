import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/ModelKeys.dart';

class PlaceModel {
  String? id;
  String? userId;
  String? name;
  String? image;
  int? status;
  String? categoryId;
  String? stateId;
  String? address;
  dynamic latitude;
  dynamic longitude;
  int? favourites;
  num? rating;
  String? description;
  List<String>? secondaryImages;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<String>? caseSearch;
  String? website;
  String? email;
  String? phone;
  String? fromMonth;
  String? toMonth;
  String? attractions;
  List<HowToReachModel>? howToReach;

  PlaceModel({
    this.id,
    this.userId,
    this.name,
    this.image,
    this.status,
    this.categoryId,
    this.stateId,
    this.address,
    this.latitude,
    this.longitude,
    this.favourites,
    this.rating,
    this.description,
    this.secondaryImages,
    this.createdAt,
    this.updatedAt,
    this.caseSearch,
    this.website,
    this.email,
    this.phone,
    this.fromMonth,
    this.toMonth,
    this.attractions,
    this.howToReach,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json[CommonKeys.id],
      userId: json[PlaceKeys.userId],
      name: json[PlaceKeys.name],
      image: json[PlaceKeys.image],
      status: json[CommonKeys.status],
      categoryId: json[PlaceKeys.categoryId],
      stateId: json[PlaceKeys.stateId],
      address: json[PlaceKeys.address],
      latitude: json[PlaceKeys.latitude],
      longitude: json[PlaceKeys.longitude],
      favourites: json[PlaceKeys.favourites],
      rating: json[PlaceKeys.rating],
      description: json[PlaceKeys.description],
      secondaryImages: json[PlaceKeys.secondaryImages]!=null ? List<String>.from(json[PlaceKeys.secondaryImages]) : [],
      createdAt: json[CommonKeys.createdAt] != null ? (json[CommonKeys.createdAt] as Timestamp).toDate() : null,
      updatedAt: json[CommonKeys.updatedAt] != null ? (json[CommonKeys.updatedAt] as Timestamp).toDate() : null,
      caseSearch: json[PlaceKeys.caseSearch] != null ? List<String>.from(json[PlaceKeys.caseSearch]) : [],
      website: json[PlaceKeys.website],
      email: json[PlaceKeys.email],
      phone: json[PlaceKeys.phone],
      fromMonth: json[PlaceKeys.fromMonth],
      toMonth: json[PlaceKeys.toMonth],
      attractions: json[PlaceKeys.attractions],
      howToReach: json[PlaceKeys.howToReach] != null ? (json[PlaceKeys.howToReach] as List).map((i) => HowToReachModel.fromJson(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[CommonKeys.id] = this.id;
    data[PlaceKeys.userId] = this.userId;
    data[PlaceKeys.name] = this.name;
    data[PlaceKeys.image] = this.image;
    data[CommonKeys.status] = this.status;
    data[PlaceKeys.categoryId] = this.categoryId;
    data[PlaceKeys.stateId] = this.stateId;
    data[PlaceKeys.address] = this.address;
    data[PlaceKeys.latitude] = this.latitude;
    data[PlaceKeys.longitude] = this.longitude;
    data[PlaceKeys.favourites] = this.favourites;
    data[PlaceKeys.rating] = this.rating;
    data[PlaceKeys.description] = this.description;
    data[PlaceKeys.secondaryImages] = this.secondaryImages;
    data[CommonKeys.createdAt] = this.createdAt;
    data[CommonKeys.updatedAt] = this.updatedAt;
    data[PlaceKeys.caseSearch] = this.caseSearch;
    data[PlaceKeys.website] = this.website;
    data[PlaceKeys.email] = this.email;
    data[PlaceKeys.phone] = this.phone;
    data[PlaceKeys.fromMonth] = this.fromMonth;
    data[PlaceKeys.toMonth] = this.toMonth;
    data[PlaceKeys.attractions] = this.attractions;
    if (this.howToReach != null) {
      data[PlaceKeys.howToReach] = this.howToReach!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class HowToReachModel {
  String? key;
  String? value;

  HowToReachModel({this.key, this.value});

  HowToReachModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}

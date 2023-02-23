class ProfileResponse {
  ProfileResponse({
      this.token, 
      this.uuid, 
      this.name, 
      this.phone, 
      this.email, 
      this.image,});

  ProfileResponse.fromJson(dynamic json) {
    token = json['token'];
    uuid = json['uuid'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
  }
  String? token;
  String? uuid;
  String? name;
  String? phone;
  String? email;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    map['uuid'] = uuid;
    map['name'] = name;
    map['phone'] = phone;
    map['email'] = email;
    map['image'] = image;
    return map;
  }

}
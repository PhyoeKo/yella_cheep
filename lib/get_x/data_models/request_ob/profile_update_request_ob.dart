
class ProfileUpdateRequestOb {
  ProfileUpdateRequestOb({
    this.type,
    this.name,
    this.password,
    this.image,
  });

  ProfileUpdateRequestOb.fromJson(dynamic json) {
    type = json['type'];
    name = json['name'];
    password = json['password'];
    oldPassword = json['oldPassword'];
    image = json['image'];
  }

  String? type;
  String? name;
  String? password;
  String? oldPassword;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['name'] = name;
    map['password'] = password;
    map['oldPassword'] = oldPassword;
    map['image'] = image;
    return map;
  }
}

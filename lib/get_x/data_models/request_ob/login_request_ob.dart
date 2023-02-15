/// loginType : "email"
/// phoneOrEmail : "userName.trim()"
/// password : "password.trim()"
/// deviceId : "234324"
/// deviceToken : ""
/// deviceOsType : "Android"

class LoginRequestOb {
  LoginRequestOb({
    String? phone,
    String? password,
  }) {
    _phone = phone;
    _password = password;
  }

  String? _phone;
  String? _password;

  String? get phone => _phone;

  String? get password => _password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone'] = _phone;
    map['password'] = _password;
    return map;
  }
}

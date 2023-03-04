/// loginType : "email"
class RegisterRequestOb {
  RegisterRequestOb({
    String? phone,
    String? name,
    String? email,
    String? password,
  }) {
    _phone = phone;
    _password = password;
    _name = name;
    _email = email;
  }

  String? _phone;
  String? _password;
  String? _name;
  String? _email;

  String? get phone => _phone;

  String? get password => _password;

  String? get name => _name;

  String? get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone'] = _phone;
    map['password'] = _password;
    map['name'] = _name;
    map['email'] = _email;
    return map;
  }
}

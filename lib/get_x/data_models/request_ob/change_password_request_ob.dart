class ChangePasswordRequestOb {
  String? currentPassword;
  String? newPassword;
  String? confirmNewPassword;

  ChangePasswordRequestOb(
      {this.currentPassword, this.newPassword, this.confirmNewPassword});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['currentPassword'] = currentPassword;
    data['newPassword'] = newPassword;
    data['confirmNewPassword'] = confirmNewPassword;
    return data;
  }
}


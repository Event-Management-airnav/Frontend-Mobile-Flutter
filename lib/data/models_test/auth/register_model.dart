class RegisterModel {
  String? name;
  String? username;
  String? email;
  String? telp;
  String? password;
  String? passwordConfirmation;
  String? statusKaryawan;

  RegisterModel({
    this.name,
    this.username,
    this.email,
    this.telp,
    this.password,
    this.passwordConfirmation,
    this.statusKaryawan,
  });

  RegisterModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    email = json['email'];
    telp = json['telp'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
    statusKaryawan = json['status_karyawan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['telp'] = this.telp;
    data['password'] = this.password;
    data['password_confirmation'] = this.passwordConfirmation;
    data['status_karyawan'] = this.statusKaryawan;
    return data;
  }
}

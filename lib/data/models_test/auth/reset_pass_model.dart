class ResetPassModel {
  String? email;
  String? token;
  String? password;
  String? passwordConfirmation;

  ResetPassModel({
    this.email,
    this.token,
    this.password,
    this.passwordConfirmation,
  });

  ResetPassModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    token = json['token'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['token'] = this.token;
    data['password'] = this.password;
    data['password_confirmation'] = this.passwordConfirmation;
    return data;
  }
}

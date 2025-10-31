import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest extends Equatable {
  final String login;
  final String password;

  const LoginRequest({
    required this.login,
    required this.password,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);

  @override
  List<Object?> get props => [login, password];
}

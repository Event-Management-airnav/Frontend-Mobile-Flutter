import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'reset_password_request.g.dart';

@JsonSerializable()
class ResetPasswordRequest extends Equatable {
  final String email;
  final String token;
  final String password;

  @JsonKey(name: "password_confirmation")
  final String passwordConfirmation;

  const ResetPasswordRequest({
    required this.email,
    required this.token,
    required this.password,
    required this.passwordConfirmation,
  });

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);

  @override
  List<Object?> get props => [
    email,
    token,
    password,
    passwordConfirmation,
  ];
}

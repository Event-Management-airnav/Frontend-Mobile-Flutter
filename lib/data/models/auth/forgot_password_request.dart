import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'forgot_password_request.g.dart';

@JsonSerializable()
class ForgotPasswordRequest extends Equatable {
  final String email;

  const ForgotPasswordRequest({
    required this.email,
  });

  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordRequestToJson(this);

  @override
  List<Object?> get props => [email];
}

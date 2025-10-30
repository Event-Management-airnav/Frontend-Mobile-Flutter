import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'otp_verify_request.g.dart';

@JsonSerializable()
class OtpVerifyRequest extends Equatable {
  final String email;
  final String otp;

  const OtpVerifyRequest({
    required this.email,
    required this.otp,
  });

  factory OtpVerifyRequest.fromJson(Map<String, dynamic> json) =>
      _$OtpVerifyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OtpVerifyRequestToJson(this);

  @override
  List<Object?> get props => [email, otp];
}

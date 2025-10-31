import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'otp_resend_request.g.dart';

@JsonSerializable()
class OtpResendRequest extends Equatable {
  final String email;

  const OtpResendRequest({
    required this.email,
  });

  factory OtpResendRequest.fromJson(Map<String, dynamic> json) =>
      _$OtpResendRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OtpResendRequestToJson(this);

  @override
  List<Object?> get props => [email];
}

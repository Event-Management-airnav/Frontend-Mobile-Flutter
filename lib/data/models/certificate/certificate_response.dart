import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'certificate_response.g.dart';

@JsonSerializable()
class CertificateResponse extends Equatable {
  CertificateResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool success;
  final String message;
  final String? data;

  factory CertificateResponse.fromJson(Map<String, dynamic> json) => _$CertificateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CertificateResponseToJson(this);

  @override
  List<Object?> get props => [
    success, message, data, ];
}

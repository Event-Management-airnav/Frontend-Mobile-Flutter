// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certificate_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CertificateResponse _$CertificateResponseFromJson(Map<String, dynamic> json) =>
    CertificateResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$CertificateResponseToJson(
  CertificateResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};

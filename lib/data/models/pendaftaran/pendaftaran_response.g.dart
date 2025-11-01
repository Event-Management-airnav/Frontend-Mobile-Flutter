// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pendaftaran_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PendaftaranResponse _$PendaftaranResponseFromJson(Map<String, dynamic> json) =>
    PendaftaranResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$PendaftaranResponseToJson(
  PendaftaranResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
};

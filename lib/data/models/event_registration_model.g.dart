// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_registration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventRegistrationModel _$EventRegistrationModelFromJson(
  Map<String, dynamic> json,
) => EventRegistrationModel(
  id: (json['id'] as num).toInt(),
  prsId: (json['prsId'] as num).toInt(),
  mdlId: (json['mdlId'] as num).toInt(),
  tanggal: DateTime.parse(json['tanggal'] as String),
  status: (json['status'] as num).toInt(),
  qrCode: json['qrCode'] as String,
);

Map<String, dynamic> _$EventRegistrationModelToJson(
  EventRegistrationModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'prsId': instance.prsId,
  'mdlId': instance.mdlId,
  'tanggal': instance.tanggal.toIso8601String(),
  'status': instance.status,
  'qrCode': instance.qrCode,
};

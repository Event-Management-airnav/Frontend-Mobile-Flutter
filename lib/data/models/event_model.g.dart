// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventModel _$EventModelFromJson(Map<String, dynamic> json) => EventModel(
  id: (json['id'] as num).toInt(),
  adm_id: (json['adm_id'] as num).toInt(),
  kode: json['kode'] as String,
  nama: json['nama'] as String,
  lokasi: json['lokasi'] as String,
  tanggal: json['tanggal'] as String,
  deskripsi: json['deskripsi'] as String,
  mulai: json['mulai'] as String,
  selesai: json['selesai'] as String,
  status: (json['status'] as num).toInt(),
);

Map<String, dynamic> _$EventModelToJson(EventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'adm_id': instance.adm_id,
      'kode': instance.kode,
      'nama': instance.nama,
      'lokasi': instance.lokasi,
      'tanggal': instance.tanggal,
      'deskripsi': instance.deskripsi,
      'mulai': instance.mulai,
      'selesai': instance.selesai,
      'status': instance.status,
    };

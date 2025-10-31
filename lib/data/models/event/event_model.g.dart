// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
  user_id: (json['user_id'] as num).toInt(),
  mdl_kode: json['mdl_kode'] as String,
  mdl_slug: json['mdl_slug'] as String,
  mdl_nama: json['mdl_nama'] as String,
  mdl_deskripsi: json['mdl_deskripsi'] as String,
  is_public: (json['is_public'] as num).toInt(),
  mdl_tipe: json['mdl_tipe'] as String,
  mdl_lokasi: json['mdl_lokasi'] as String,
  mdl_latitute: (json['mdl_latitute'] as num).toDouble(),
  mdl_longitude: (json['mdl_longitude'] as num).toDouble(),
  radius: (json['radius'] as num).toInt(),
  mdl_pendaftaran_mulai: DateTime.parse(
    json['mdl_pendaftaran_mulai'] as String,
  ),
  mdl_pendaftaran_selesai: DateTime.parse(
    json['mdl_pendaftaran_selesai'] as String,
  ),
  mdl_maks_peserta_offline: (json['mdl_maks_peserta_offline'] as num).toInt(),
  mdl_maks_peserta_online: (json['mdl_maks_peserta_online'] as num).toInt(),
  mdl_acara_mulai: DateTime.parse(json['mdl_acara_mulai'] as String),
  mdl_acara_selesai: DateTime.parse(json['mdl_acara_selesai'] as String),
  mdl_status: json['mdl_status'] as String,
  mdl_file_acara: json['mdl_file_acara'] as String,
  mdl_file_rundown: json['mdl_file_rundown'] as String,
  mdl_template_sertifikat: json['mdl_template_sertifikat'] as String,
  mdl_sertifikat_aktif: (json['mdl_sertifikat_aktif'] as num).toInt(),
  mdl_doorprize_aktif: (json['mdl_doorprize_aktif'] as num).toInt(),
  mdl_banner_acara: json['mdl_banner_acara'] as String,
  mdl_catatan: json['mdl_catatan'] as String,
);

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
  'user_id': instance.user_id,
  'mdl_kode': instance.mdl_kode,
  'mdl_slug': instance.mdl_slug,
  'mdl_nama': instance.mdl_nama,
  'mdl_deskripsi': instance.mdl_deskripsi,
  'is_public': instance.is_public,
  'mdl_tipe': instance.mdl_tipe,
  'mdl_lokasi': instance.mdl_lokasi,
  'mdl_latitute': instance.mdl_latitute,
  'mdl_longitude': instance.mdl_longitude,
  'radius': instance.radius,
  'mdl_pendaftaran_mulai': instance.mdl_pendaftaran_mulai.toIso8601String(),
  'mdl_pendaftaran_selesai': instance.mdl_pendaftaran_selesai.toIso8601String(),
  'mdl_maks_peserta_offline': instance.mdl_maks_peserta_offline,
  'mdl_maks_peserta_online': instance.mdl_maks_peserta_online,
  'mdl_acara_mulai': instance.mdl_acara_mulai.toIso8601String(),
  'mdl_acara_selesai': instance.mdl_acara_selesai.toIso8601String(),
  'mdl_status': instance.mdl_status,
  'mdl_file_acara': instance.mdl_file_acara,
  'mdl_file_rundown': instance.mdl_file_rundown,
  'mdl_template_sertifikat': instance.mdl_template_sertifikat,
  'mdl_sertifikat_aktif': instance.mdl_sertifikat_aktif,
  'mdl_doorprize_aktif': instance.mdl_doorprize_aktif,
  'mdl_banner_acara': instance.mdl_banner_acara,
  'mdl_catatan': instance.mdl_catatan,
};

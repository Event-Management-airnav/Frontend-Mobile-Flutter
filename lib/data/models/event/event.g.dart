// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
  id: (json['id'] as num).toInt(),
  slug: json['slug'] as String,
  nama: json['nama'] as String,
  tipe: json['tipe'] as String,
  lokasi: json['lokasi'] as String?,
  tanggalMulai: json['tanggal_mulai'] as String?,
  tanggalMulaiRaw: json['tanggal_mulai_raw'] as String?,
  statusAcara: json['status_acara'] as String?,
  statusEvent: json['status_event'] as String?,
  banner: json['banner'] as String?,
  deskripsiSingkat: json['deskripsi_singkat'] as String?,
  mdlKode: json['mdl_kode'] as String?,
  mdlPresensiAktif: (json['mdl_presensi_aktif'] as num?)?.toInt(),
);

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
  'id': instance.id,
  'slug': instance.slug,
  'nama': instance.nama,
  'tipe': instance.tipe,
  'lokasi': instance.lokasi,
  'tanggal_mulai': instance.tanggalMulai,
  'tanggal_mulai_raw': instance.tanggalMulaiRaw,
  'status_acara': instance.statusAcara,
  'status_event': instance.statusEvent,
  'banner': instance.banner,
  'deskripsi_singkat': instance.deskripsiSingkat,
  'mdl_kode': instance.mdlKode,
  'mdl_presensi_aktif': instance.mdlPresensiAktif,
};

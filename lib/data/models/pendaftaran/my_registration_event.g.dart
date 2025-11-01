// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_registration_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyRegistrationEvent _$MyRegistrationEventFromJson(Map<String, dynamic> json) =>
    MyRegistrationEvent(
      id: (json['id'] as num).toInt(),
      kode: json['mdl_kode'] as String?,
      slug: json['mdl_slug'] as String?,
      nama: json['mdl_nama'] as String?,
      kategori: json['mdl_kategori'] as String?,
      tipe: json['mdl_tipe'] as String?,
      lokasi: json['mdl_lokasi'] as String?,
      acaraMulai: json['mdl_acara_mulai'] as String?,
      acaraSelesai: json['mdl_acara_selesai'] as String?,
      status: json['mdl_status'] as String?,
    );

Map<String, dynamic> _$MyRegistrationEventToJson(
  MyRegistrationEvent instance,
) => <String, dynamic>{
  'id': instance.id,
  'mdl_kode': instance.kode,
  'mdl_slug': instance.slug,
  'mdl_nama': instance.nama,
  'mdl_kategori': instance.kategori,
  'mdl_tipe': instance.tipe,
  'mdl_lokasi': instance.lokasi,
  'mdl_acara_mulai': instance.acaraMulai,
  'mdl_acara_selesai': instance.acaraSelesai,
  'mdl_status': instance.status,
};

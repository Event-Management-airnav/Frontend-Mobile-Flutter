// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventDetailResponse _$EventDetailResponseFromJson(Map<String, dynamic> json) =>
    EventDetailResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: EventDetailData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventDetailResponseToJson(
  EventDetailResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data.toJson(),
};

EventDetailData _$EventDetailDataFromJson(Map<String, dynamic> json) =>
    EventDetailData(
      event: EventDetail.fromJson(json['event'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventDetailDataToJson(EventDetailData instance) =>
    <String, dynamic>{'event': instance.event.toJson()};

EventDetail _$EventDetailFromJson(Map<String, dynamic> json) => EventDetail(
  id: (json['id'] as num).toInt(),
  kode: json['kode'] as String,
  slug: json['slug'] as String,
  nama: json['nama'] as String,
  deskripsi: json['deskripsi'] as String,
  mdlKodeQr: json['mdl_kode_qr'] as String?,
  mdlPresensiAktif: (json['mdl_presensi_aktif'] as num).toInt(),
  tipe: json['tipe'] as String,
  statusAcara: json['status_acara'] as String,
  lokasi: json['lokasi'] as String?,
  latitude: json['latitude'] as String?,
  longitude: json['longitude'] as String?,
  radius: (json['radius'] as num?)?.toInt(),
  pendaftaran: json['pendaftaran'] == null
      ? null
      : Pendaftaran.fromJson(json['pendaftaran'] as Map<String, dynamic>),
  acara: json['acara'] == null
      ? null
      : Acara.fromJson(json['acara'] as Map<String, dynamic>),
  kapasitas: json['kapasitas'] == null
      ? null
      : Kapasitas.fromJson(json['kapasitas'] as Map<String, dynamic>),
  status: json['status'] as String,
  sertifikatAktif: (json['sertifikat_aktif'] as num).toInt(),
  doorprizeAktif: (json['doorprize_aktif'] as num).toInt(),
  banner: json['banner'] as String?,
  catatan: json['catatan'] as String?,
  createdAt: json['created_at'] as String,
);

Map<String, dynamic> _$EventDetailToJson(EventDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kode': instance.kode,
      'slug': instance.slug,
      'nama': instance.nama,
      'deskripsi': instance.deskripsi,
      'mdl_kode_qr': instance.mdlKodeQr,
      'mdl_presensi_aktif': instance.mdlPresensiAktif,
      'tipe': instance.tipe,
      'status_acara': instance.statusAcara,
      'lokasi': instance.lokasi,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'radius': instance.radius,
      'pendaftaran': instance.pendaftaran?.toJson(),
      'acara': instance.acara?.toJson(),
      'kapasitas': instance.kapasitas?.toJson(),
      'status': instance.status,
      'sertifikat_aktif': instance.sertifikatAktif,
      'doorprize_aktif': instance.doorprizeAktif,
      'banner': instance.banner,
      'catatan': instance.catatan,
      'created_at': instance.createdAt,
    };

Pendaftaran _$PendaftaranFromJson(Map<String, dynamic> json) => Pendaftaran(
  mulai: json['mulai'] as String,
  selesai: json['selesai'] as String,
  mulaiRaw: json['mulai_raw'] as String,
  selesaiRaw: json['selesai_raw'] as String,
  isOpen: json['is_open'] as bool,
);

Map<String, dynamic> _$PendaftaranToJson(Pendaftaran instance) =>
    <String, dynamic>{
      'mulai': instance.mulai,
      'selesai': instance.selesai,
      'mulai_raw': instance.mulaiRaw,
      'selesai_raw': instance.selesaiRaw,
      'is_open': instance.isOpen,
    };

Acara _$AcaraFromJson(Map<String, dynamic> json) => Acara(
  mulai: json['mulai'] as String,
  selesai: json['selesai'] as String,
  mulaiRaw: json['mulai_raw'] as String,
  selesaiRaw: json['selesai_raw'] as String,
);

Map<String, dynamic> _$AcaraToJson(Acara instance) => <String, dynamic>{
  'mulai': instance.mulai,
  'selesai': instance.selesai,
  'mulai_raw': instance.mulaiRaw,
  'selesai_raw': instance.selesaiRaw,
};

Kapasitas _$KapasitasFromJson(Map<String, dynamic> json) => Kapasitas(
  offline: (json['offline'] as num?)?.toInt(),
  online: (json['online'] as num?)?.toInt(),
);

Map<String, dynamic> _$KapasitasToJson(Kapasitas instance) => <String, dynamic>{
  'offline': instance.offline,
  'online': instance.online,
};

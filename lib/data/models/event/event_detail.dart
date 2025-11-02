import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_detail.g.dart';

@JsonSerializable()
class EventDetailResponse extends Equatable {
  final bool success;
  final String message;
  final EventDetailData data;

  const EventDetailResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory EventDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$EventDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EventDetailResponseToJson(this);

  @override
  List<Object?> get props => [success, message, data];
}

@JsonSerializable()
class EventDetailData extends Equatable {
  final EventDetail event;

  const EventDetailData({
    required this.event,
  });

  factory EventDetailData.fromJson(Map<String, dynamic> json) =>
      _$EventDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$EventDetailDataToJson(this);

  @override
  List<Object?> get props => [event];
}

@JsonSerializable()
class EventDetail extends Equatable {
  final int id;
  final String kode;
  final String slug;
  final String nama;
  final String deskripsi;

  @JsonKey(name: 'mdl_kode_qr')
  final String? mdlKodeQr;

  @JsonKey(name: 'mdl_presensi_aktif')
  final int presensiAktif;

  final String tipe;

  @JsonKey(name: 'status_acara')
  final String statusAcara;

  final String? lokasi;
  final String? latitude;
  final String? longitude;
  final int? radius;
  final Pendaftaran? pendaftaran;
  final Acara? acara;
  final Kapasitas? kapasitas;
  final String? status;

  @JsonKey(name: 'sertifikat_aktif')
  final int sertifikatAktif;

  @JsonKey(name: 'doorprize_aktif')
  final int doorprizeAktif;

  final String? banner;
  final String? catatan;

  const EventDetail({
    required this.id,
    required this.kode,
    required this.slug,
    required this.nama,
    required this.deskripsi,
    this.mdlKodeQr,
    required this.presensiAktif,
    required this.tipe,
    required this.statusAcara,
    this.lokasi,
    this.latitude,
    this.longitude,
    this.radius,
    this.pendaftaran,
    this.acara,
    this.kapasitas,
    this.status,
    required this.sertifikatAktif,
    required this.doorprizeAktif,
    this.banner,
    this.catatan,
  });

  factory EventDetail.fromJson(Map<String, dynamic> json) =>
      _$EventDetailFromJson(json);

  Map<String, dynamic> toJson() => _$EventDetailToJson(this);

  @override
  List<Object?> get props => [
    id,
    kode,
    slug,
    nama,
    deskripsi,
    mdlKodeQr,
    presensiAktif,
    tipe,
    statusAcara,
    lokasi,
    latitude,
    longitude,
    radius,
    pendaftaran,
    acara,
    kapasitas,
    status,
    sertifikatAktif,
    doorprizeAktif,
    banner,
    catatan,
  ];
}

@JsonSerializable()
class Pendaftaran extends Equatable {
  final String? mulai;
  final String? selesai;

  @JsonKey(name: 'mulai_raw')
  final String? mulaiRaw;

  @JsonKey(name: 'selesai_raw')
  final String? selesaiRaw;

  @JsonKey(name: 'is_open')
  final bool? isOpen;

  const Pendaftaran({
    this.mulai,
    this.selesai,
    this.mulaiRaw,
    this.selesaiRaw,
    this.isOpen,
  });

  factory Pendaftaran.fromJson(Map<String, dynamic> json) =>
      _$PendaftaranFromJson(json);

  Map<String, dynamic> toJson() => _$PendaftaranToJson(this);

  @override
  List<Object?> get props => [mulai, selesai, mulaiRaw, selesaiRaw, isOpen];
}

@JsonSerializable()
class Acara extends Equatable {
  final String? mulai;
  final String? selesai;

  @JsonKey(name: 'mulai_raw')
  final String? mulaiRaw;

  @JsonKey(name: 'selesai_raw')
  final String? selesaiRaw;

  const Acara({
    this.mulai,
    this.selesai,
    this.mulaiRaw,
    this.selesaiRaw,
  });

  factory Acara.fromJson(Map<String, dynamic> json) =>
      _$AcaraFromJson(json);

  Map<String, dynamic> toJson() => _$AcaraToJson(this);

  @override
  List<Object?> get props => [mulai, selesai, mulaiRaw, selesaiRaw];
}

@JsonSerializable()
class Kapasitas extends Equatable {
  final int? offline;
  final int? online;

  const Kapasitas({
    this.offline,
    this.online,
  });

  factory Kapasitas.fromJson(Map<String, dynamic> json) =>
      _$KapasitasFromJson(json);

  Map<String, dynamic> toJson() => _$KapasitasToJson(this);

  @override
  List<Object?> get props => [offline, online];
}

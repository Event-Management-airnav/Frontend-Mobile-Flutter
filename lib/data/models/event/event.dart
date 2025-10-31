import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable()
class Event extends Equatable {
  final int id;
  final String slug;
  final String nama;
  final String tipe;
  final String? lokasi;

  @JsonKey(name: 'tanggal_mulai')
  final String? tanggalMulai;

  @JsonKey(name: 'tanggal_mulai_raw')
  final String? tanggalMulaiRaw;

  @JsonKey(name: 'status_acara')
  final String? statusAcara;

  @JsonKey(name: 'status_event')
  final String? statusEvent;

  final String? banner;

  @JsonKey(name: 'deskripsi_singkat')
  final String? deskripsiSingkat;

  @JsonKey(name: 'mdl_kode')
  final String? mdlKode;

  @JsonKey(name: 'mdl_presensi_aktif')
  final int? mdlPresensiAktif;

  const Event({
    required this.id,
    required this.slug,
    required this.nama,
    required this.tipe,
    this.lokasi,
    this.tanggalMulai,
    this.tanggalMulaiRaw,
    this.statusAcara,
    this.statusEvent,
    this.banner,
    this.deskripsiSingkat,
    this.mdlKode,
    this.mdlPresensiAktif,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);

  @override
  List<Object?> get props => [
    id,
    slug,
    nama,
    tipe,
    lokasi,
    tanggalMulai,
    tanggalMulaiRaw,
    statusAcara,
    statusEvent,
    banner,
    deskripsiSingkat,
    mdlKode,
    mdlPresensiAktif,
  ];
}

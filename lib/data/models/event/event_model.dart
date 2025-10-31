import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_model.g.dart';

@JsonSerializable()
class Event extends Equatable {
  final int user_id;
  final String mdl_kode;
  final String mdl_slug;
  final String mdl_nama;
  final String mdl_deskripsi;
  final int is_public;
  final String mdl_tipe;
  final String mdl_lokasi;
  final double mdl_latitute;
  final double mdl_longitude;
  final int radius;
  final DateTime mdl_pendaftaran_mulai;
  final DateTime mdl_pendaftaran_selesai;
  final int mdl_maks_peserta_offline;
  final int mdl_maks_peserta_online;
  final DateTime mdl_acara_mulai;
  final DateTime mdl_acara_selesai;
  final String mdl_status;
  final String mdl_file_acara;
  final String mdl_file_rundown;
  final String mdl_template_sertifikat;
  final int mdl_sertifikat_aktif;
  final int mdl_doorprize_aktif;
  final String mdl_banner_acara;
  final String mdl_catatan;

  const Event({
    required this.user_id,
    required this.mdl_kode,
    required this.mdl_slug,
    required this.mdl_nama,
    required this.mdl_deskripsi,
    required this.is_public,
    required this.mdl_tipe,
    required this.mdl_lokasi,
    required this.mdl_latitute,
    required this.mdl_longitude,
    required this.radius,
    required this.mdl_pendaftaran_mulai,
    required this.mdl_pendaftaran_selesai,
    required this.mdl_maks_peserta_offline,
    required this.mdl_maks_peserta_online,
    required this.mdl_acara_mulai,
    required this.mdl_acara_selesai,
    required this.mdl_status,
    required this.mdl_file_acara,
    required this.mdl_file_rundown,
    required this.mdl_template_sertifikat,
    required this.mdl_sertifikat_aktif,
    required this.mdl_doorprize_aktif,
    required this.mdl_banner_acara,
    required this.mdl_catatan,
  });

  factory Event.fromJson(Map<String, dynamic> json) =>
      _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);

  @override
  List<Object?> get props => [
        user_id,
        mdl_kode,
        mdl_slug,
        mdl_nama,
        mdl_deskripsi,
        is_public,
        mdl_tipe,
        mdl_lokasi,
        mdl_latitute,
        mdl_longitude,
        radius,
        mdl_pendaftaran_mulai,
        mdl_pendaftaran_selesai,
        mdl_maks_peserta_offline,
        mdl_maks_peserta_online,
        mdl_acara_mulai,
        mdl_acara_selesai,
        mdl_status,
        mdl_file_acara,
        mdl_file_rundown,
        mdl_template_sertifikat,
        mdl_sertifikat_aktif,
        mdl_doorprize_aktif,
        mdl_banner_acara,
        mdl_catatan,
      ];
}

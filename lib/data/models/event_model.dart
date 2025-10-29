import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_model.g.dart';

@JsonSerializable()
class EventModel extends Equatable {
  final int id;
  final int adm_id;
  final String kode;
  final String nama;
  final String lokasi;
  final String tanggal;
  final String deskripsi;
  final String mulai;
  final String selesai;
  final int status;

  const EventModel({
    required this.id,
    required this.adm_id,
    required this.kode,
    required this.nama,
    required this.lokasi,
    required this.tanggal,
    required this.deskripsi,
    required this.mulai,
    required this.selesai,
    required this.status,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventModelToJson(this);

  @override
  List<Object?> get props =>
      [id, adm_id, kode, nama, lokasi, tanggal, deskripsi, mulai, selesai, status];
}

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_registration_event.g.dart';

@JsonSerializable()
class MyRegistrationEvent extends Equatable {
  final int id;

  @JsonKey(name: 'mdl_kode')
  final String? kode;

  @JsonKey(name: 'mdl_slug')
  final String? slug;

  @JsonKey(name: 'mdl_nama')
  final String? nama;

  @JsonKey(name: 'mdl_kategori')
  final String? kategori;

  @JsonKey(name: 'mdl_tipe')
  final String? tipe;

  @JsonKey(name: 'mdl_lokasi')
  final String? lokasi;

  @JsonKey(name: 'mdl_acara_mulai')
  final String? acaraMulai;

  @JsonKey(name: 'mdl_acara_selesai')
  final String? acaraSelesai;

  @JsonKey(name: 'mdl_status')
  final String? status;

  const MyRegistrationEvent({
    required this.id,
    this.kode,
    this.slug,
    this.nama,
    this.kategori,
    this.tipe,
    this.lokasi,
    this.acaraMulai,
    this.acaraSelesai,
    this.status,
  });

  factory MyRegistrationEvent.fromJson(Map<String, dynamic> json) =>
      _$MyRegistrationEventFromJson(json);

  Map<String, dynamic> toJson() => _$MyRegistrationEventToJson(this);

  @override
  List<Object?> get props =>
      [id, kode, slug, nama, kategori, tipe, lokasi, acaraMulai, acaraSelesai, status];
}

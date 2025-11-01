import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'my_registration_event.dart';

part 'my_registration.g.dart';

@JsonSerializable()
class MyRegistration extends Equatable {
  final int id;

  @JsonKey(name: 'modul_acara_id')
  final int modulAcaraId;

  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'metode_daftar')
  final String metodeDaftar;

  @JsonKey(name: 'waktu_daftar')
  final String waktuDaftar;

  @JsonKey(name: 'has_doorprize')
  final int hasDoorprize;

  @JsonKey(name: 'no_sertifikat')
  final String? noSertifikat;

  @JsonKey(name: 'modul_acara')
  final MyRegistrationEvent modulAcara;

  const MyRegistration({
    required this.id,
    required this.modulAcaraId,
    required this.userId,
    required this.metodeDaftar,
    required this.waktuDaftar,
    required this.hasDoorprize,
    this.noSertifikat,
    required this.modulAcara,
  });

  factory MyRegistration.fromJson(Map<String, dynamic> json) =>
      _$MyRegistrationFromJson(json);

  Map<String, dynamic> toJson() => _$MyRegistrationToJson(this);

  @override
  List<Object?> get props =>
      [id, modulAcaraId, userId, metodeDaftar, waktuDaftar, hasDoorprize, noSertifikat];
}

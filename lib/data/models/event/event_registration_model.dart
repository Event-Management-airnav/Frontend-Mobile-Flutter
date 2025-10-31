import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_registration_model.g.dart';

@JsonSerializable()
class EventRegistration extends Equatable {
  final int id;
  final int prsId;
  final int mdlId;
  final DateTime tanggal;
  final int status;
  final String qrCode;

  const EventRegistration({
    required this.id,
    required this.prsId,
    required this.mdlId,
    required this.tanggal,
    required this.status,
    required this.qrCode,
  });

  factory EventRegistration.fromJson(Map<String, dynamic> json) =>
      _$EventRegistrationFromJson(json);

  Map<String, dynamic> toJson() => _$EventRegistrationToJson(this);

  @override
  List<Object?> get props => [id, prsId, mdlId, tanggal, status, qrCode];
}

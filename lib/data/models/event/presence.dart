import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'presence.g.dart';

@JsonSerializable()
class Presence extends Equatable {
  Presence({
    required this.kode,
  });

  final String kode;

  factory Presence.fromJson(Map<String, dynamic> json) => _$PresenceFromJson(json);

  Map<String, dynamic> toJson() => _$PresenceToJson(this);

  @override
  List<Object?> get props => [
    kode, ];
}

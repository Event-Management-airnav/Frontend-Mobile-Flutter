import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pendaftaran_response.g.dart';

@JsonSerializable()
class PendaftaranResponse extends Equatable {
  final bool success;
  final String message;

  const PendaftaranResponse({
    required this.success,
    required this.message,
  });

  factory PendaftaranResponse.fromJson(Map<String, dynamic> json) =>
      _$PendaftaranResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PendaftaranResponseToJson(this);

  @override
  List<Object?> get props => [success, message];
}

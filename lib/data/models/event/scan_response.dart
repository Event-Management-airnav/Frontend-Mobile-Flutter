import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'scan_response.g.dart';

@JsonSerializable()
class ScanResponse extends Equatable {
  ScanResponse({
    required this.status,
    required this.message,
  });

  final bool status;
  final String message;

  factory ScanResponse.fromJson(Map<String, dynamic> json) => _$ScanResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ScanResponseToJson(this);

  @override
  List<Object?> get props => [
    status, message, ];
}

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'basic_response.g.dart';

@JsonSerializable()
class BasicResponse extends Equatable {
  final bool success;
  final String message;

  const BasicResponse({
    required this.success,
    required this.message,
  });

  factory BasicResponse.fromJson(Map<String, dynamic> json) =>
      _$BasicResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BasicResponseToJson(this);

  @override
  List<Object?> get props => [success, message];
}

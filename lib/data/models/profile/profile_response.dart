import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'profile_model.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse extends Equatable {
  final bool success;
  final String message;
  final ProfileModel? data;

  const ProfileResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);

  @override
  List<Object?> get props => [success, message, data];
}

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'user.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse extends Equatable {
  final bool success;
  final String message;
  final Map<String, dynamic>? errors;
  final RegisterData? data;

  const RegisterResponse({
    required this.success,
    required this.message,
    this.errors,
    this.data,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);

  @override
  List<Object?> get props => [success, message, errors, data];
}

@JsonSerializable()
class RegisterData extends Equatable {
  final User user;

  const RegisterData({required this.user});

  factory RegisterData.fromJson(Map<String, dynamic> json) =>
      _$RegisterDataFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterDataToJson(this);

  @override
  List<Object?> get props => [user];
}

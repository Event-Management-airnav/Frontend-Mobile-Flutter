import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel extends Equatable {
  final int id;
  final String name;
  final String username;
  final String email;
  final String telp;
  final String role;

  @JsonKey(name: "email_verified_at")
  final String? emailVerifiedAt;

  @JsonKey(name: "profile_photo")
  final String? profilePhoto;

  @JsonKey(name: "status_karyawan")
  final int statusKaryawan;

  const ProfileModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.telp,
    required this.role,
    this.emailVerifiedAt,
    this.profilePhoto,
    required this.statusKaryawan,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);

  @override
  List<Object?> get props => [
    id,
    name,
    username,
    email,
    telp,
    role,
    emailVerifiedAt,
    profilePhoto,
    statusKaryawan,
  ];
}

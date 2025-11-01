// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  username: json['username'] as String,
  email: json['email'] as String,
  telp: json['telp'] as String,
  role: json['role'] as String,
  emailVerifiedAt: json['email_verified_at'] as String?,
  profilePhoto: json['profile_photo'] as String?,
  statusKaryawan: (json['status_karyawan'] as num).toInt(),
);

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'email': instance.email,
      'telp': instance.telp,
      'role': instance.role,
      'email_verified_at': instance.emailVerifiedAt,
      'profile_photo': instance.profilePhoto,
      'status_karyawan': instance.statusKaryawan,
    };

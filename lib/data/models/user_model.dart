import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  final int id;
  final String name;
  final String username;
  final String email;
  final String telp;
  final String role;
  final String remember_token;
  final String foto; // TODO backend belum ada foto

  const UserModel ({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.telp,
    required this.role,
    required this.remember_token,
    required this.foto,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);



  @override
  List<Object?> get props => [id, name, username, email, telp, role, remember_token, foto];
}
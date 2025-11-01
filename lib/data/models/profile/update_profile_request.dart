import 'dart:io';
import 'package:equatable/equatable.dart';

class UpdateProfileRequest extends Equatable {
  final String name;
  final String telp;
  final File? profilePhoto;

  const UpdateProfileRequest({
    required this.name,
    required this.telp,
    this.profilePhoto,
  });

  @override
  List<Object?> get props => [name, telp, profilePhoto];
}

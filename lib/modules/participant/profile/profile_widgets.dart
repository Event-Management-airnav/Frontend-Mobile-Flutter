import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_mobile_flutter/modules/participant/profile/profile_controller.dart';
import 'package:get/get.dart';

// Widget untuk menampilkan baris informasi di halaman profil
class ProfileInfoTile extends StatelessWidget {
  final String label;
  final String value;

  const ProfileInfoTile({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Dialog untuk mengedit profil pengguna
class EditProfileDialog extends GetView<ProfileController> {
  const EditProfileDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Edit Data',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                const Center(
                  child: Text(
                    'Ubah Foto',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      controller.pickImageFromGallery();
                    },
                    child: Obx(() {
                      // === PERUBAHAN DI SINI ===
                      ImageProvider? dialogImage;
                      if (controller.selectedImageFile.value != null) {
                        // Prioritas 1: Tampilkan gambar baru yang dipilih untuk pratinjau
                        dialogImage = FileImage(controller.selectedImageFile.value!);
                      } else if (controller.profileImageFile.value != null) {
                        // Prioritas 2: Tampilkan gambar profil lokal yang aktif
                        dialogImage = FileImage(controller.profileImageFile.value!);
                      } else if (controller.profileImageUrl.isNotEmpty) {
                        // Prioritas 3: Tampilkan gambar profil dari internet
                        dialogImage = NetworkImage(controller.profileImageUrl.value);
                      }

                      return Stack(
                        children: [
                          CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.grey[200],
                            backgroundImage: dialogImage,
                            child: (dialogImage == null)
                                ? Icon(
                                    Icons.person,
                                    size: 60,
                                    color: Colors.grey[400],
                                  )
                                : null,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                                decoration: const BoxDecoration(
                                    color: Color(0xFF175FA4), shape: BoxShape.circle),
                                child: const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                )),
                          )
                        ],
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 24),
                _EditField(
                    label: 'Nama Lengkap', hint: 'Nama Lengkap baru...', controller: controller.nameController),
                const SizedBox(height: 16),
                _EditField(
                    label: 'No. Whatsapp', hint: 'No. Whatsapp baru...', controller: controller.whatsappController),
                const SizedBox(height: 16),
                _EditField(label: 'Email', hint: 'Email baru...', controller: controller.emailController),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: controller.updateProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF175FA4),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Simpan Perubahan Data',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget internal untuk kolom input di dalam EditProfileDialog
class _EditField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;

  const _EditField({required this.label, required this.hint, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: label == 'No. Whatsapp'
              ? TextInputType.number
              : TextInputType.text,
          inputFormatters: label == 'No. Whatsapp'
              ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
              : [],
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }
}


// Dialog untuk mengubah kata sandi
class ChangePasswordDialog extends GetView<ProfileController> {
  const ChangePasswordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Ubah Kata Sandi',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Kata Sandi Baru',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Obx(() => TextField(
                      controller: controller.passwordController,
                      obscureText: controller.isPasswordObscured1.value,
                      decoration: InputDecoration(
                        hintText: 'Masukkan password baru',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordObscured1.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey[600],
                          ),
                          onPressed: () {
                            controller.isPasswordObscured1.toggle();
                          },
                        ),
                      ),
                    )),
                const SizedBox(height: 16),
                Text(
                  'Ketik Ulang Password Baru',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Obx(() => TextField(
                      controller: controller.confirmPasswordController,
                      obscureText: controller.isPasswordObscured2.value,
                      decoration: InputDecoration(
                        hintText: 'Konfirmasi password baru',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordObscured2.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey[600],
                          ),
                          onPressed: () {
                            controller.isPasswordObscured2.toggle();
                          },
                        ),
                      ),
                    )),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: controller.changePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF175FA4),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Simpan Kata Sandi',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

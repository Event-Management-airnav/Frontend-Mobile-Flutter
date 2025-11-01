import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_mobile_flutter/modules/participant/profile/profile_controller.dart';
import 'package:frontend_mobile_flutter/modules/participant/profile/profile_widgets.dart';
import 'package:get/get.dart';

// Kelas utama untuk halaman profil, terhubung dengan ProfileController melalui GetView.
class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold menyediakan struktur dasar untuk layout halaman.
    return Scaffold(
      backgroundColor: Colors.grey[100],
      // AppBar adalah bar bagian atas halaman.
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        // Judul AppBar yang berisi logo dan nama perusahaan.
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png', // Pastikan path logo benar
              height: 30,
            ),
            const SizedBox(width: 10),
            // Kolom untuk menyusun teks "AirNav" dan "Indonesia" secara vertikal.
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AirNav',
                  style: TextStyle(
                    color: Color(0xFF175FA4),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    height: 1.2,
                  ),
                ),
                Text(
                  'Indonesia',
                  style: TextStyle(
                    color: Color(0xFF5A6B7B),
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ],
        ),
        // Actions adalah widget yang ditempatkan di sisi kanan AppBar (contoh: tombol logout).
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Implement logout functionality
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
          ),
        ],
      ),
      // Body utama halaman yang dapat di-scroll.
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          // Card sebagai container utama untuk informasi profil.
          child: Card(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Judul kartu informasi.
                  const Text(
                    'Informasi Profil',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Obx membungkus widget agar menjadi reaktif terhadap perubahan state di controller.
                  Obx(() {
                    // Logika untuk menentukan gambar mana yang akan ditampilkan.
                    ImageProvider? backgroundImage;
                    if (controller.profileImageFile.value != null) {
                      backgroundImage = FileImage(controller.profileImageFile.value!);
                    } else if (controller.profileImageUrl.isNotEmpty) {
                      backgroundImage = NetworkImage(controller.profileImageUrl.value);
                    }

                    // GestureDetector menangkap aksi ketukan pada gambar profil.
                    return GestureDetector(
                      onTap: () {
                        // Jika ada gambar, tampilkan dalam mode layar penuh.
                        if (backgroundImage != null) {
                          Get.dialog(
                            GestureDetector(
                              onTap: () => Get.back(), // Klik di mana saja untuk menutup.
                              child: Container(
                                color: Colors.black.withOpacity(0.8),
                                // InteractiveViewer memungkinkan zoom dan pan pada gambar.
                                child: InteractiveViewer(
                                  panEnabled: true,
                                  minScale: 0.5,
                                  maxScale: 4,
                                  child: Center(
                                    child: Image(image: backgroundImage),
                                  ),
                                ),
                              ),
                            ),
                            useSafeArea: false,
                          );
                        }
                      },
                      // CircleAvatar untuk menampilkan gambar profil dalam bentuk lingkaran.
                      child: Center(
                        child: CircleAvatar(
                          radius: 80,
                          backgroundImage: backgroundImage,
                          child: (backgroundImage == null)
                              ? Icon(Icons.person, size: 80, color: Colors.grey[400])
                              : null,
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 30),
                  // Menampilkan informasi nama, whatsapp, dan email secara reaktif.
                  Obx(() => ProfileInfoTile(label: 'Nama Lengkap', value: controller.name.value)),
                  const SizedBox(height: 12),
                  Obx(() => ProfileInfoTile(label: 'No. Whatsapp', value: controller.whatsapp.value)),
                  const SizedBox(height: 12),
                  Obx(() => ProfileInfoTile(label: 'Email', value: controller.email.value)),
                  const SizedBox(height: 36),
                  // Row untuk menata tombol secara horizontal.
                  Row(
                    children: [
                      // Tombol untuk membuka dialog edit profil.
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            controller.initEditForm();
                            Get.dialog(const EditProfileDialog());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF175FA4),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Edit Profil',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Tombol untuk membuka dialog ubah kata sandi.
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            controller.initChangePasswordForm();
                            Get.dialog(const ChangePasswordDialog());
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            side: const BorderSide(color: Color(0xFF175FA4), width: 1.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            foregroundColor: const Color(0xFF175FA4),
                          ),
                          child: const Text(
                            'Ubah Kata Sandi',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfo(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[500], fontSize: 14)),
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

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: _buildChangePasswordDialog(),
        );
      },
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: _buildEditProfileDialog(context),
        );
      },
    );
  }

  Widget _buildEditProfileDialog(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              const Center(
                child: Text(
                  'Ubah Foto',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.grey[200],
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.grey[400],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF175FA4),
                          shape: BoxShape.circle,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 17),
              _buildEditField('Nama Lengkap', 'Nama Lengkap baru...'),
              const SizedBox(height: 10),
              _buildEditField('No. Whatsapp', 'No. Whatsapp baru...'),
              const SizedBox(height: 10),
              _buildEditField('Email', 'Email baru...'),
              const SizedBox(height: 17),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement save profile logic
                  Navigator.of(context).pop();
                },
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
    );
  }

  Widget _buildEditField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChangePasswordDialog() {
    bool obscurePassword1 = true;
    bool obscurePassword2 = true;

    return StatefulBuilder(
      builder: (context, setState) {
        return Dialog(
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Kata Sandi Lama',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    obscureText: obscurePassword1,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword1
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey[600],
                        ),
                        onPressed: () {
                          setState(() {
                            obscurePassword1 = !obscurePassword1;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Kata Sandi Baru',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    obscureText: obscurePassword2,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword2
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey[600],
                        ),
                        onPressed: () {
                          setState(() {
                            obscurePassword2 = !obscurePassword2;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement password change logic
                      Navigator.of(context).pop();
                    },
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
        );
      },
    );
  }
}

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
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// Controller untuk mengelola state dan logika halaman profil.
class ProfileController extends GetxController {
  // -- STATE REAKTIF (.obs) --
  final RxString profileImageUrl = ''.obs; // Menyimpan URL gambar dari server.
  final Rx<File?> profileImageFile = Rx<File?>(null); // Menyimpan file gambar lokal yang aktif.
  final RxString name = ''.obs; // Menyimpan nama pengguna.
  final RxString whatsapp = ''.obs; // Menyimpan nomor whatsapp pengguna.
  final RxString email = ''.obs; // Menyimpan email pengguna.

  // State untuk pratinjau gambar di dialog.
  final Rx<File?> selectedImageFile = Rx<File?>(null);

  // State untuk visibilitas password di dialog.
  final RxBool isPasswordObscured1 = true.obs;
  final RxBool isPasswordObscured2 = true.obs;

  // -- TEXT CONTROLLERS --
  // Untuk mendapatkan input dari kolom teks.
  late TextEditingController nameController;
  late TextEditingController whatsappController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  // Metode yang dijalankan saat controller pertama kali diinisialisasi.
  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    whatsappController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    fetchUserProfile(); // Mengambil data profil awal.
  }

  // Metode yang dijalankan saat controller akan dihapus.
  @override
  void onClose() {
    nameController.dispose();
    whatsappController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // --- FUNGSI-FUNGSI LOGIKA ---

  // Mengambil data profil awal (saat ini masih simulasi).
  void fetchUserProfile() {
    profileImageUrl.value = 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80';
    name.value = 'Akbar Maulana';
    whatsapp.value = '+62 895-1720-0895';
    email.value = 'akbarmaulana212@airnav.com';
  }

  // Menginisialisasi form edit dengan data saat ini.
  void initEditForm() {
    nameController.text = name.value;
    whatsappController.text = whatsapp.value;
    emailController.text = email.value;
    selectedImageFile.value = null;
  }

  // Mereset form ubah password sebelum dialog muncul.
  void initChangePasswordForm() {
    passwordController.clear();
    confirmPasswordController.clear();
    isPasswordObscured1.value = true;
    isPasswordObscured2.value = true;
  }

  // Membuka galeri untuk memilih gambar.
  Future<void> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedImageFile.value = File(image.path);
    } else {
      print('No image selected.');
    }
  }

  // Logika untuk menyimpan perubahan profil.
  void updateProfile() {
    if (selectedImageFile.value != null) {
      profileImageFile.value = selectedImageFile.value;
      profileImageUrl.value = '';
      print('API UPDATE PROFILE: Mengunggah gambar baru: ${selectedImageFile.value!.path}');
    }

    print('API UPDATE PROFILE DIPANGGIL DENGAN DATA:');
    print('Nama: ${nameController.text}');

    name.value = nameController.text;
    whatsapp.value = whatsappController.text;
    email.value = emailController.text;

    Get.back(); // Menutup dialog.
    Get.snackbar('Berhasil', 'Profil berhasil diperbarui.', backgroundColor: Colors.green, colorText: Colors.white);
  }

  // Logika untuk menyimpan kata sandi baru.
  void changePassword() {
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar('Gagal', 'Password tidak cocok.', backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    if (passwordController.text.isEmpty) {
      Get.snackbar('Gagal', 'Password tidak boleh kosong.', backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    print('API UBAH PASSWORD DIPANGGIL DENGAN PASSWORD: ${passwordController.text}');

    Get.back(); // Menutup dialog.
    Get.snackbar('Berhasil', 'Kata sandi berhasil diubah.', backgroundColor: Colors.green, colorText: Colors.white);
  }
}

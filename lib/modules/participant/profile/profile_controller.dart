import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  // -- STATE REAKTIF (.obs) --
  final RxString profileImageUrl = ''.obs;
  final Rx<File?> profileImageFile = Rx<File?>(null);

  // === VARIABEL YANG HILANG & KINI DITAMBAHKAN KEMBALI ===
  final RxString name = ''.obs;
  final RxString whatsapp = ''.obs;
  final RxString email = ''.obs;
  // =======================================================

  // State untuk file gambar yang baru dipilih di dialog
  final Rx<File?> selectedImageFile = Rx<File?>(null);

  // -- STATE REAKTIF UNTUK DIALOG --
  final RxBool isPasswordObscured1 = true.obs;
  final RxBool isPasswordObscured2 = true.obs;

  // -- TEXT CONTROLLERS --
  late TextEditingController nameController;
  late TextEditingController whatsappController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    whatsappController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    fetchUserProfile();
  }

  @override
  void onClose() {
    nameController.dispose();
    whatsappController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // --- FUNGSI UNTUK LOGIKA --- 

  void fetchUserProfile() {
    profileImageUrl.value = 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80';
    name.value = 'Akbar Maulana';
    whatsapp.value = '+62 895-1720-0895';
    email.value = 'akbarmaulana212@airnav.com';
  }

  void initEditForm() {
    nameController.text = name.value;
    whatsappController.text = whatsapp.value;
    emailController.text = email.value;
    selectedImageFile.value = null;
  }

  void initChangePasswordForm() {
    passwordController.clear();
    confirmPasswordController.clear();
    isPasswordObscured1.value = true;
    isPasswordObscured2.value = true;
  }

  Future<void> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedImageFile.value = File(image.path);
    } else {
      print('No image selected.');
    }
  }

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

    Get.back();
    Get.snackbar('Berhasil', 'Profil berhasil diperbarui.', backgroundColor: Colors.green, colorText: Colors.white);
  }

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

    Get.back();
    Get.snackbar('Berhasil', 'Kata sandi berhasil diubah.', backgroundColor: Colors.green, colorText: Colors.white);
  }
}

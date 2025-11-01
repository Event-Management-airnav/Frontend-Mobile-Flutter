import 'package:flutter/material.dart';
import 'package:frontend_mobile_flutter/modules/participant/profile/profile_widgets.dart';
import 'package:frontend_mobile_flutter/modules/participant/profile/widgets/call_to_login.dart';
import 'package:get/get.dart';

import 'package:frontend_mobile_flutter/modules/participant/profile/profile_controller.dart';

import '../../../app_pages.dart';
import '../activity/widgets/app_bar.dart';



class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(),
      body: SafeArea(
        child: Obx(() {
          if (!controller.isLoggedIn.value) {
            return CallToLogin();
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
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
                      Obx(() {
                        ImageProvider? backgroundImage;
                        if (controller.profileImageFile.value != null) {
                          backgroundImage = FileImage(controller.profileImageFile.value!);
                        } else if (controller.profileImageUrl.isNotEmpty) {
                          backgroundImage = NetworkImage(controller.profileImageUrl.value);
                        }

                        return GestureDetector(
                          onTap: () {
                            if (backgroundImage != null) {
                              Get.dialog(
                                GestureDetector(
                                  onTap: () => Get.back(),
                                  child: Container(
                                    color: Colors.black.withOpacity(0.8),
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
                      Obx(() => ProfileInfoTile(label: 'Nama Lengkap', value: controller.name.value)),
                      const SizedBox(height: 12),
                      Obx(() => ProfileInfoTile(label: 'No. Whatsapp', value: controller.whatsapp.value)),
                      const SizedBox(height: 12),
                      Obx(() => ProfileInfoTile(label: 'Email', value: controller.email.value)),
                      const SizedBox(height: 36),
                      Row(
                        children: [
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
          );
        }),
      ),
    );
  }
}

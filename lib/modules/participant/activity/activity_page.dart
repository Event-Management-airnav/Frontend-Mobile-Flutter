import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:frontend_mobile_flutter/modules/participant/activity/activity_controller.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/widgets/activity_container.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/widgets/app_bar.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/widgets/search_bar.dart';

import '../../../app_pages.dart';

class ActivityPage extends GetView<ActivityController> {
  const ActivityPage({super.key});


  String statusMap(String status) {
    switch (status) {
      case 'closed':
        return 'Selesai';
      case 'active':
        return 'Berlangsung';
      default:
        return 'Unknown';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Obx(() {

          if (!controller.isLoggedIn.value) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.person_off_outlined, size: 100, color: Colors.grey),
                    const SizedBox(height: 24),
                    const Text(
                      'Anda Belum Login',
                      textAlign: TextAlign.center,

                      
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Silakan login atau daftar untuk melihat profil Anda.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () => Get.offAllNamed(Routes.AUTH),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF175FA4),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Login / Daftar',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          backgroundColor: Colors.blue[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.error.value != null) {
            return Center(child: Text('Error: ${controller.error.value}'));
          }
          final items = controller.filteredFollowed;

          if (items.isEmpty) {
            return const Center(child: Text('Belum ada aktivitas'));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TSearchBar(),
              const SizedBox(height: 10),
              const Text(
                'Aktivitas',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: controller.refreshFollowed,
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (_, i) {
                      final d = items[i];
                      final name = controller.eventNameOf(d);
                      final date = controller.formatDate(controller.eventDateOf(d));
                      final status = statusMap(controller.statusOf(d));
                      if (status == 'Unknown') return const SizedBox.shrink();

                      return ActivityContainer(
                        eventName: name,
                        eventDate: date,
                        status: status,
                        onTap: () => Get.toNamed(Routes.DETAIL, arguments: d),
                        onActionTap: (){
                          if (status == 'Selesai'){
                            Get.snackbar('Sertifikat', 'Fitur Unduh sertifikat akan segera hadir.');
                          } else if (status == 'Berlangsung'){
                            Get.snackbar('Scan QR Code', 'Scan untuk absensi kegiatan.');
                            Get.toNamed(Routes.SCAN);
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

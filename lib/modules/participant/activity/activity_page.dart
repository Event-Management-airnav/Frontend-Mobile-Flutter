import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/activity_controller.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/widgets/activity_container.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/widgets/app_bar.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/widgets/search_bar.dart';
import 'package:frontend_mobile_flutter/modules/participant/profile/widgets/call_to_login.dart';

import '../../../app_pages.dart';
import '../../../core/utils.dart';

class ActivityPage extends GetView<ActivityController> {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Obx(() {
          // Belum login -> ajak login
          if (!controller.isLoggedIn.value) {
            return const CallToLogin(page: "acara");
          }

          // Loading awal
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final items = controller.filteredFollowed;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TSearchBar(),
              const SizedBox(height: 10),
              const Text(
                'Aktivitas',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 10),

              // Area list + pull-to-refresh
              Expanded(
                child: RefreshIndicator(
                  onRefresh: controller.refreshFollowed, // Future<void> expected
                  child: items.isEmpty
                  // ====== STATE KOSONG: tetap scrollable agar RefreshIndicator mau jalan ======
                      ? LayoutBuilder(
                    builder: (context, constraints) {
                      return ListView(
                        physics:
                        const AlwaysScrollableScrollPhysics(), // penting
                        children: [
                          SizedBox(
                            height: constraints.maxHeight,
                            child: const Center(
                              child: Text('Belum ada aktivitas'),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                  // ====== STATE ADA DATA ======
                      : ListView.separated(
                    physics:
                    const AlwaysScrollableScrollPhysics(), // tetap bisa tarik refresh walau item sedikit
                    itemCount: items.length,
                    separatorBuilder: (_, _) =>
                    const SizedBox(height: 8),
                    itemBuilder: (_, i) {
                      final d = items[i];
                      final name = d.modulAcara.mdlNama;
                      final date = controller
                          .formatDate(d.modulAcara.mdlAcaraMulai);
                      final status = controller.eventStatus(d);

                      if (status == 'Unknown') {
                        return const SizedBox.shrink();
                      }

                      //bool isPresent = d.presensi != null && d.presensi?.status == "Hadir"; belum bener
                      bool isPresent = true;
                      if (kDebugMode) {
                        print("activity page url:${d.certificateUrl}");
                        print("hadir ga: $isPresent");
                      }
                      return ActivityContainer(
                        event: d,
                        eventName: name,
                        eventDate: date,
                        status: status,
                        isPresent: isPresent,
                        hasDoorprize: d.hasDoorprize == 1,
                        timeNow: controller.timeNow.value,
                        onCardPressed: () async {
                          await Get.toNamed(
                            Routes.DETAIL,
                            arguments: {
                              "id": d.modulAcaraId,
                              "data": d,
                            },
                          );
                          // refresh setelah kembali dari detail
                          await controller.refreshFollowed();
                        },
                        onDownloadCertificatePressed: () async {
                          var res = await controller.getCertificateForEvent(d.modulAcaraId);
                          if (res != null && res.status) {
                            final url = res.data;
                            Utils.openUrl(url);
                            Get.snackbar('Berhasil', 'Sertifikat berhasil diunduh.', backgroundColor: Colors.green, colorText: Colors.white);
                          } else {
                            Get.snackbar('Gagal', res?.message ?? 'Terjadi kesalahan saat mengunduh sertifikat.', backgroundColor: Colors.red, colorText: Colors.white);

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

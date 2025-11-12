import 'package:flutter/material.dart';
import 'package:frontend_mobile_flutter/core/app_colors.dart';
import 'package:frontend_mobile_flutter/modules/event_detail/event_detail_controller.dart';
import 'package:frontend_mobile_flutter/modules/participant/home/widgets/fail_register.dart';
import 'package:frontend_mobile_flutter/modules/participant/home/widgets/new_register_event_popup.dart';
import 'package:frontend_mobile_flutter/modules/participant/home/widgets/success_register.dart';
import 'package:get/get.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/widgets/app_bar.dart';
import 'package:intl/intl.dart';

import '../../core/utils.dart';
import '../participant/home/widgets/event_hero_card.dart';
import '../participant/home/widgets/about_event_card.dart';
import '../participant/home/widgets/section_tile_card.dart';
import '../participant/home/widgets/info_list_card.dart';
import '../participant/home/widgets/additional_info_card.dart';

class DetailPage extends GetView<EventDetailController> {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map;
    final eventId = args["id"];
    final data = args["data"]; // Keep for existing logic if needed

    controller.loadEventDetail(eventId);
    if (controller.isUserLoggedIn.value) {
      controller.loadRegistration(eventId);
    }

    Future<void> _refresh() async {
      await controller.loadEventDetail(eventId);
      if (controller.isUserLoggedIn.value) {
        await controller.loadRegistration(eventId);
      }
    }

    return Scaffold(
      appBar: TAppBar(),
      body: Obx(() {
        // Helper for states that need to be scrollable for the refresh indicator to work
        Widget buildScrollableFeedback(Widget child) {
          return RefreshIndicator(
            onRefresh: _refresh,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      height: constraints.maxHeight,
                      child: Center(child: child),
                    ),
                  ],
                );
              },
            ),
          );
        }

        // Show full-page loader only on initial load.
        // During pull-to-refresh, isLoading is true but hasData is also true,
        // so this block won't be triggered, showing the indicator at the top instead.
        if (controller.isLoading.value && !controller.hasData) {
          return buildScrollableFeedback(const CircularProgressIndicator());
        }

        if (controller.hasError) {
          return buildScrollableFeedback(const Text("Detail acara tidak bisa ditampilkan"));
        }

        if (controller.hasData) {
          final event = controller.eventDetail.value!;

          final eventRegStart =
              DateFormat("d MMM yyyy, HH:mm", "id_ID").format(event.pendaftaranMulai);
          final eventRegEnd =
              DateFormat("d MMM yyyy, HH:mm", "id_ID").format(event.pendaftaranSelesai);
          final eventStart =
              DateFormat("d MMM yyyy, HH:mm", "id_ID").format(event.acaraMulai);
          final eventEnd = event.acaraSelesai != null
              ? DateFormat("d MMM yyyy, HH:mm", "id_ID").format(event.acaraSelesai!)
              : '';
          final eventStartFull =
          DateFormat("d MMMM yyy, HH:mm", "id_ID").format(event.acaraMulai);

          return RefreshIndicator(
            onRefresh: _refresh,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EventHeroCard(
                    title: event.nama,
                    location: event.lokasi ?? 'N/A',
                    dateTimeText: eventStartFull,
                    imageUrl: event.bannerAcara,
                    borderColor: AppColors.primary,
                  ),
                  const SizedBox(height: 20),
                  AboutEventCard(
                    titleWidget: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.titleLarge,
                        children: const [TextSpan(text: 'Tentang Acara')],
                      ),
                    ),
                    description: event.deskripsi,
                    primaryColor: AppColors.primary,
                    shareUrl:
                    'https://airnav-event.vercel.app/user/event/${event.id}',

                    isLoggedIn: controller.isUserLoggedIn.value,
                    isRegistered: controller.isRegistered.value,
                    registrationStartDate: event.pendaftaranMulai,
                    registrationEndDate: event.pendaftaranSelesai,
                    eventStartDate: event.acaraMulai,
                    eventEndDate:
                    event.acaraSelesai ??
                        event.acaraMulai.add(const Duration(days: 1)),
                    isAttendanceActive: event.presensiAktif,

                    onLogin: controller.goToLogin,
                    onRegister: () {
                      Get.dialog(AttendanceDialog(eventId: eventId));
                    },
                    onCancelRegistration: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Batal Pendaftaran'),
                          content: const Text(
                            'Apakah Anda yakin ingin membatalkan pendaftaran acara ini?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Get.back(),
                              child: const Text('Tidak'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () async {
                                Get.back();
                                final errorMessage = await controller
                                    .cancelRegistration(eventId);
                                if (errorMessage == null) {
                                  SuccessRegister.show(
                                    context,
                                    title: 'SUCCESS',
                                    subtitle: 'Pembatalan Berhasil',
                                  );
                                } else {
                                  FailRegister.show(
                                    context,
                                    title: 'FAILED',
                                    subtitle: errorMessage,
                                  );
                                }
                              },
                              child: const Text(
                                'Batalkan',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    onScan: controller.scanQrCode,
                  ),
                  const SizedBox(height: 16),
                  if (controller.isRegistered.value) ...[
                    if (event.fileRundown != null)
                      SectionTileCard(
                        leadingIcon: Icons.description_outlined,
                        iconColor: AppColors.primary,
                        title: 'Susunan Acara',
                        trailing: IconButton(
                          onPressed: () {
                            if (event.fileRundown != null) {
                              Utils.openUrl(event.fileRundown);
                            }
                          },
                          icon: const Icon(Icons.download_rounded),
                          color: AppColors.primary,
                        ),
                        onTap: () {},
                      ),
                    const SizedBox(height: 10),
                    if (event.fileAcara != null)
                      SectionTileCard(
                        leadingIcon: Icons.menu_book_outlined,
                        iconColor: AppColors.primary,
                        title: 'Modul Acara',
                        trailing: IconButton(
                          onPressed: () {
                            if (event.fileAcara != null) {
                              Utils.openUrl(event.fileAcara);
                            }
                          },
                          icon: const Icon(Icons.download_rounded),
                          color: AppColors.primary,
                        ),
                        onTap: () {},
                      ),
                    const SizedBox(height: 16),
                  ],
                  InfoListCard(
                    title: 'Informasi Acara',
                    items: [
                      InfoItem(
                        leading: const Icon(
                          Icons.location_on_outlined,
                          size: 20,
                        ),
                        label: 'Alamat',
                        value: event.lokasi ?? 'Online',
                      ),
                      InfoItem(
                        leading: const Icon(
                          Icons.event_available_outlined,
                          size: 20,
                        ),
                        label: 'Pendaftaran Dibuka',
                        value: eventRegStart,
                      ),
                      InfoItem(
                        leading: const Icon(
                          Icons.event_busy_outlined,
                          size: 20,
                        ),
                        label: 'Pendaftaran Ditutup',
                        value: eventRegEnd,
                      ),
                      InfoItem(
                        leading: const Icon(
                          Icons.play_circle_outline_rounded,
                          size: 20,
                        ),
                        label: 'Acara mulai',
                        value: eventStart,
                      ),
                      if (event.acaraSelesai != null) InfoItem(
                        leading: const Icon(
                          Icons.stop_circle_outlined,
                          size: 20,
                        ),
                        label: 'Acara selesai',
                        value: eventEnd,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (event.catatan != null && event.catatan!.isNotEmpty)
                    AdditionalInfoCard(
                      title: 'Informasi Tambahan',
                      contentLines: event.catatan!.split('\n'),
                    ),
                ],
              ),
            ),
          );
        }

        return buildScrollableFeedback(const Text('No event data available.'));
      }),
    );
  }
}

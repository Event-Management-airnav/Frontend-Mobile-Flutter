import 'package:flutter/material.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/widgets/app_bar.dart';
import 'package:frontend_mobile_flutter/modules/participant/home/home_controller.dart';
import 'package:frontend_mobile_flutter/modules/participant/home/notification_button.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';
import '../../../data/models/event/event.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: TAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            // const SizedBox(height: 16),
            // TextField(
            //   decoration: InputDecoration(
            //     hintText: "Cari acara...",
            //     prefixIcon: const Icon(Icons.search),
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(30),
            //       borderSide: BorderSide.none,
            //     ),
            //     filled: true,
            //     fillColor: Colors.white,
            //     contentPadding: const EdgeInsets.symmetric(
            //       horizontal: 16,
            //       vertical: 0,
            //     ),
            //   ),
            // ),
            const SizedBox(height: 16),
            Obx(() {
              final active = controller.activeFilter.value;
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 12.0,
                    runSpacing: 4.0,
                    children: <Widget>[
                      ChoiceChip.elevated(
                        elevation: 1,
                        backgroundColor: const Color(0xFFEBFAFF),
                        selectedColor: Colors.blue[200],
                        label: const Text('All'),
                        selected: active == null,
                        onSelected: (_) {
                          // Tapping "All" clears filter
                          controller.activeFilter.value = null;
                        },
                      ),
                      ChoiceChip.elevated(
                        elevation: 1,
                        backgroundColor: const Color(0xFFEBFAFF),
                        selectedColor: Colors.blue[200],
                        label: const Text('Active'),
                        selected: active == HomeFilter.active,
                        onSelected: (_) =>
                            controller.toggleFilter(HomeFilter.active),
                      ),
                      ChoiceChip.elevated(
                        elevation: 1,
                        backgroundColor: const Color(0xFFEBFAFF),
                        selectedColor: Colors.blue[200],
                        label: const Text('Upcoming'),
                        selected: active == HomeFilter.upcoming,
                        onSelected: (_) =>
                            controller.toggleFilter(HomeFilter.upcoming),
                      ),
                      ChoiceChip.elevated(
                        elevation: 1,
                        backgroundColor: const Color(0xFFEBFAFF),
                        selectedColor: Colors.blue[200],
                        label: const Text('Past'),
                        selected: active == HomeFilter.past,
                        onSelected: (_) =>
                            controller.toggleFilter(HomeFilter.past),
                      ),
                    ],
                  ),
                ],
              );
            }),

            const SizedBox(height: 12),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final list = controller.visibleEvents;
                if (list.isEmpty) {
                  return const Center(
                    child: Text('Belum Ada Acara'),
                  );
                }
                return ListView.separated(
                  itemCount: list.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final event = {
                      'name': 'Rapat Tinjauan Manajemen (RTM) Tahun 2024',
                      'date': '17 Agu 2024',
                      'time': '09:00 - 12:00',
                      'location': 'Ruang Rapat A',
                      'status': 'Selesai',
                      // 'Terbuka', 'Berlangsung', 'Selesai'
                      'imageUrl': 'assets/images/dashboard_user_card_image.png',
                    }; // TODO fetch from data

                    final Event e = list[index];
                    return _EventListTile(event: e);
                  },
                );

              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _EventListTile extends StatelessWidget {
  final Event event;

  const _EventListTile({required this.event});

  @override
  Widget build(BuildContext context) {
    final waktu = event.tanggalMulai!;
    final tanggal = waktu.substring(0, 11);
    final jam = waktu.substring(waktu.length - 5);
    final lokasi = event.lokasi!;

    Color statusColor;
    switch (event.statusEvent) {
      case 'Berlangsung':
        statusColor = Colors.green.shade100;
        break;
      case 'Akan Datang':
        statusColor = Colors.yellow.shade100;
        break;
      case 'Selesai':
        statusColor = Colors.red.shade100;
        break;
      default:
        statusColor = Colors.grey.shade100;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(

        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/dashboard_user_card_image.png', // TODO change to network image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .start,
                    children: [
                      Text(
                        event.nama,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 2.0,
                        runSpacing: 2.0,
                        children: [
                          _buildEventInfo(
                            Icons.calendar_today,
                            tanggal,
                          ),
                          _buildEventInfo(
                            Icons.access_time,
                            jam,
                          ),
                          _buildEventInfo(
                            Icons.location_on,
                            lokasi.length > 13 ? '${lokasi.substring(0, 10)}...' : lokasi,
                          ),
                          _buildEventInfo(
                            Icons.circle,
                            event.statusAcara!,
                            backgroundColor: statusColor,
                            iconSize: 10,
                            textColor: Colors.black87,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue[500]!,
                    Colors.blue[400]!
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  minimumSize: const Size.fromHeight(30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Detail Acara',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildEventInfo(
    IconData icon,
    String label, {
      Color backgroundColor = AppColors.chipBackground,
      Color textColor = Colors.black54,
      double iconSize = 16,
    }) {
  return Container(
    margin: const EdgeInsets.only(right: 4, bottom: 4),
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: iconSize, color: textColor),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 10, color: textColor)),
      ],
    ),
  );
}

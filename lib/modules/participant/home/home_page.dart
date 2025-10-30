import 'package:flutter/material.dart';
import 'package:frontend_mobile_flutter/modules/participant/home/home_controller.dart';
import 'package:frontend_mobile_flutter/modules/participant/home/notification_button.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0), // Set the desired height
        child: AppBar(
          title: Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 35, // TODO extract to constants
                  height: 35,
                  child: Image(image: AssetImage('assets/images/appbar_logo_airnav.png'))
                ),
                const SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Event Management',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'AirNav Indonesia',
                      style: TextStyle(
                        color: Colors.grey[700], // TODO use style color
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          actions: [
            NotificationButton(notificationCount: 1, onPressed: () => {}), // TODO add new notification indicator
            const SizedBox(width: 8.0),
            const SizedBox(
              width: 40,
              height: 40,
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/user_image.jpg"),
              ),
            ), // TODO user avatar fetch
            const SizedBox(width: 16.0),
          ],
          backgroundColor: Colors.white,
          elevation: 1,
          scrolledUnderElevation: 0,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: "Cari acara...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: <Widget>[
                    FilterChip(
                      label: const Text('Terbuka'),
                      selected: true, // TODO fetch from controller
                      onSelected: (bool selected) {},
                      selectedColor: Colors.blue[100],
                      showCheckmark: false,
                      backgroundColor: Colors.grey[200],
                    ),
                    FilterChip(
                      label: const Text('Berlangsung'),
                      selected: false, // TODO fetch from controller
                      onSelected: (bool selected) {},
                      selectedColor: Colors.blue[100],
                      showCheckmark: false,
                      backgroundColor: Colors.grey[200],
                    ),
                    FilterChip(
                      label: const Text('Selesai'),
                      selected: false, // TODO fetch from controller
                      onSelected: (bool selected) {},
                      selectedColor: Colors.blue[100],
                      showCheckmark: false,
                      backgroundColor: Colors.grey[200],
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  final event = {
                    'name': 'Rapat Tinjauan Manajemen (RTM) Tahun 2024',
                    'date': '17 Agu 2024',
                    'time': '09:00 - 12:00',
                    'location': 'Ruang Rapat A',
                    'status': 'Selesai', // 'Terbuka', 'Berlangsung', 'Selesai'
                    'imageUrl': 'assets/images/dashboard_user_card_image.png'
                  }; // TODO fetch from data

                  Color statusColor;
                  switch (event['status']) {
                    case 'Terbuka':
                      statusColor = Colors.green.shade100;
                      break;
                    case 'Berlangsung':
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
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    event['imageUrl']!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      event['name']!,
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
                                        _buildEventInfo(Icons.calendar_today, event['date']!),
                                        _buildEventInfo(Icons.access_time, event['time']!),
                                        _buildEventInfo(Icons.location_on, event['location']!),
                                        _buildEventInfo(
                                          Icons.circle,
                                          event['status']!,
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
                                  Colors.blue[400]!,
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
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
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
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

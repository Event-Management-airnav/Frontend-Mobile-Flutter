import 'package:flutter/material.dart';
import 'package:frontend_mobile_flutter/modules/participant/notification/notification_controller.dart';
import 'package:get/get.dart';

class NotificationPage extends GetView<NotificationController> {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Notifikasi',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.black, size: 26),
            onPressed: () {
              // TODO: Implement delete all notifications logic
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // TODO: Implement mark all as read logic
              },
              child: const Text(
                'Tandai semua sudah dibaca',
                style: TextStyle(
                  color: Color(0xFF007BFF),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          _buildNotificationItem(
            icon: 'assets/images/logo.png', // Ganti dengan path logo Anda
            title: 'Ada Event Baru!',
            message: 'Ayo ikuti event yang penuh inspirasi dan hadiah menarik 🚀',
            time: '1h',
            isUnread: true,
            color: const Color(0xFFEAF6FF),
          ),
          const SizedBox(height: 12),
          _buildNotificationItem(
            icon: 'assets/images/logo.png', // Ganti dengan path logo Anda
            title: 'Kamu Telah Mendaftar!',
            message: 'Terima kasih telah mendaftar. Siap-siap ikuti keseruannya! 💥',
            time: '1h',
            isUnread: true,
            color: const Color(0xFFEAFEEF),
          ),
          const SizedBox(height: 12),
          _buildNotificationItem(
            icon: 'assets/images/logo.png', // Ganti dengan path logo Anda
            title: 'Ada Event Baru!',
            message: 'Ayo ikuti event yang penuh inspirasi dan hadiah menarik 🚀',
            time: '1h',
            isUnread: false,
            color: const Color(0xFFF0F0F0),
          ),
          const SizedBox(height: 12),
          _buildNotificationItem(
            icon: 'assets/images/logo.png', // Ganti dengan path logo Anda
            title: 'Kamu Telah Mendaftar!',
            message: 'Terima kasih telah mendaftar. Siap-siap ikuti keseruannya! 💥',
            time: '1h',
            isUnread: false,
            color: const Color(0xFFF0F0F0),
          ),
        ],
      ),
    );
  }

}
Widget _buildNotificationItem({
  required String icon,
  required String title,
  required String message,
  required String time,
  required bool isUnread,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: isUnread ? color : const Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                  )
                ],
              ),
              child: Image.asset(icon, height: 24, width: 24),
            ),
            if (isUnread)
              Positioned(
                top: -2,
                right: -2,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                message,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          time,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}

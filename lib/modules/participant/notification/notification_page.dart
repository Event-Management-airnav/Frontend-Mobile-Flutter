import 'package:flutter/material.dart';
import 'package:frontend_mobile_flutter/modules/participant/notification/notification_controller.dart';
import 'package:get/get.dart';

// Halaman untuk menampilkan daftar notifikasi kepada pengguna.
class NotificationPage extends GetView<NotificationController> {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold menyediakan struktur dasar untuk layout halaman.
    return Scaffold(
      backgroundColor: Colors.white,
      // AppBar adalah bar bagian atas halaman.
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // Tombol kembali untuk navigasi ke halaman sebelumnya.
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        // Judul halaman.
        title: const Text(
          'Notifikasi',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        // Ikon aksi di sebelah kanan AppBar.
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.black, size: 26),
            onPressed: () {
              // TODO: Implement delete all notifications logic
            },
          ),
        ],
      ),
      // ListView untuk menampilkan daftar notifikasi yang bisa di-scroll.
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: [
          // Tombol untuk menandai semua notifikasi telah dibaca.
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
          // Contoh item notifikasi (saat ini masih menggunakan data statis).
          _buildNotificationItem(
            icon: 'assets/images/logo.png',
            title: 'Ada Event Baru!',
            message: 'Ayo ikuti event yang penuh inspirasi dan hadiah menarik 🚀',
            time: '1h',
            isUnread: true,
            color: const Color(0xFFEAF6FF),
          ),
          const SizedBox(height: 12),
          _buildNotificationItem(
            icon: 'assets/images/logo.png',
            title: 'Kamu Telah Mendaftar!',
            message: 'Terima kasih telah mendaftar. Siap-siap ikuti keseruannya! 💥',
            time: '1h',
            isUnread: true,
            color: const Color(0xFFEAFEEF),
          ),
          const SizedBox(height: 12),
          _buildNotificationItem(
            icon: 'assets/images/logo.png',
            title: 'Ada Event Baru!',
            message: 'Ayo ikuti event yang penuh inspirasi dan hadiah menarik 🚀',
            time: '1h',
            isUnread: false,
            color: const Color(0xFFF0F0F0),
          ),
          const SizedBox(height: 12),
          _buildNotificationItem(
            icon: 'assets/images/logo.png',
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

  // Widget private untuk membangun satu item notifikasi.
  Widget _buildNotificationItem({
    required String icon,
    required String title,
    required String message,
    required String time,
    required bool isUnread,
    required Color color,
  }) {
    // Container utama untuk setiap item notifikasi.
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isUnread ? color : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stack untuk menumpuk ikon dan titik notifikasi (jika belum dibaca).
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
              // Menampilkan titik merah jika notifikasi belum dibaca.
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
          // Expanded agar teks notifikasi mengisi sisa ruang.
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Judul notifikasi.
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                // Pesan notifikasi.
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
          // Waktu notifikasi diterima.
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
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationButton extends StatelessWidget {
  final int notificationCount;
  final VoidCallback? onPressed;

  const NotificationButton({
    super.key,
    required this.notificationCount,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Lingkaran dengan IconButton di dalamnya
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFEBFAFF), // background biru muda
          ),
          child: IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: onPressed ??
                () => Get.snackbar(
                      'Notification',
                      'You tapped on the notification button',
                    ),
          ),
        ),

        // Badge merah di kanan atas
        if (notificationCount > 0)
          Positioned(
            right: 4,
            top: 4,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Center(
                child: Text(
                  notificationCount > 99 ? '99+' : '$notificationCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

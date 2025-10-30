import 'package:flutter/material.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/widgets/notification_button.dart';
import 'package:get/get.dart';

class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar({super.key});

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // 👈 required

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Image.asset(
            'assets/logo.png',
            height: 35,
          ),
          const SizedBox(width: 8),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Aktivitas Saya', style: TextStyle(fontSize: 16)),
              Text('AirNav Indonesia', style: TextStyle(fontSize: 12)),
            ],
          ),
          const Spacer(),
          NotificationButton(
            notificationCount: 5,
            onPressed: () {
              Get.snackbar(
                  'Notification', 'You tapped on the notification button');
            },
          ),
          const CircleAvatar(
            backgroundImage: AssetImage('assets/logo.png'),
            radius: 20,
          ),
        ],
      ),
    );
  }
}

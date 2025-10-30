import 'package:flutter/material.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/activity_controller.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/widgets/activity_container.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/widgets/app_bar.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/widgets/search_bar.dart';
import 'package:get/get.dart';

class ActivityPage extends GetView<ActivityController> {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSearchBar(),
            SizedBox(height: 10),
            const Text('Aktivitas',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
            ActivityContainer(
              eventName: 'Seminar Flutter',
              eventDate: '29 Oct 2025',
              status: 'On Going',
              onTap: () =>
                  Get.snackbar('Card tapped', 'You tapped on the card'),
              onActionTap: () =>
                  Get.snackbar('Button tapped', 'You tapped on the button'),
            ),
            ActivityContainer(
              eventName: 'Seminar Flutter',
              eventDate: '29 Oct 2025',
              status: 'Selesai',
              onTap: () =>
                  Get.snackbar('Card tapped', 'You tapped on the card'),
              onActionTap: () =>
                  Get.snackbar('Button tapped', 'You tapped on the button'),
            )
          ],
        ),
      ),
    );
  }
}

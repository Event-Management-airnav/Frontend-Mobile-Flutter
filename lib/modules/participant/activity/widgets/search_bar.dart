import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../activity_controller.dart';

class TSearchBar extends StatelessWidget {
  const TSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ActivityController>();

    return TextFormField(
      onChanged: controller.updateSearchQuery,
      decoration: const InputDecoration(
        hintText: 'Cari acaramu...',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      ),
    );
  }
}

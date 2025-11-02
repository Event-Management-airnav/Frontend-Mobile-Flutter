import 'package:flutter/material.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/widgets/filter_button.dart';
import 'package:get/get.dart';
import '../activity_controller.dart';

class TSearchBar extends StatelessWidget {
  const TSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ActivityController>();

    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Aktivitas....',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
          ),
          onChanged: (value) {},
        ),
        const SizedBox(height: 10),

        // FILTER row
        Obx(() {
          final selected = c.selectedFilter.value;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FilterButton(
                  icon: Icon(
                    Icons.check_circle,
                    color: selected == ActivityFilter.mendatang ? Colors.white : Colors.black,
                  ),
                  text: 'Belum Mulai',
                  onPressed: () => c.selectFilter(ActivityFilter.mendatang),
                  isSelected: selected == ActivityFilter.mendatang,
                ),
                const SizedBox(width: 10),

                FilterButton(
                  icon: Icon(
                    Icons.check_circle,
                    color: selected == ActivityFilter.berlangsung ? Colors.white : Colors.black,
                  ),
                  text: 'Berlangsung',
                  onPressed: () => c.selectFilter(ActivityFilter.berlangsung),
                  isSelected: selected == ActivityFilter.berlangsung,
                ),
                const SizedBox(width: 10),

                FilterButton(
                  icon: Icon(
                    Icons.pending,
                    color: selected == ActivityFilter.selesai ? Colors.white : Colors.black,
                  ),
                  text: 'Selesai',
                  onPressed: () => c.selectFilter(ActivityFilter.selesai),
                  isSelected: selected == ActivityFilter.selesai,
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/widgets/filter_button.dart';

class TSearchBar extends StatelessWidget {
  const TSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Search
        TextField(
          decoration: InputDecoration(
            hintText: 'Aktivitas....',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
          ),
          onChanged: (value) {
            // Handle search input changes
          },
        ),
        SizedBox(height: 10),
        //Filter
        Row(
          children: [
            FilterButton(
              icon: Icon(Icons.check_circle),
              onPressed: () {},
              text: 'Selesai',
            ),
            SizedBox(width: 10),
            FilterButton(
                onPressed: () {},
                icon: Icon(Icons.check_circle_outline),
                text: 'On Going'),
          ],
        )
      ],
    );
  }
}

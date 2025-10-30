import 'package:flutter/material.dart';
import 'package:frontend_mobile_flutter/core/app_colors.dart';

class GreetingHeader extends StatelessWidget {
  final String userName;
  final String subtitle;
  const GreetingHeader({
    super.key,
    required this.userName,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selamat Datang, $userName!',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

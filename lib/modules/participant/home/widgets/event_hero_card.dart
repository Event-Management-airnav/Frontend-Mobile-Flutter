import 'package:flutter/material.dart';

class EventHeroCard extends StatelessWidget {
  final String title;
  final String location;
  final String dateTimeText;
  final String imageAsset;
  final Color borderColor;

  const EventHeroCard({
    super.key,
    required this.title,
    required this.location,
    required this.dateTimeText,
    required this.imageAsset,
    this.borderColor = const Color(0xFF005EA2),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1),
        color: Colors.white,
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          // Gambar full
          Positioned.fill(
            child: Image.asset(
              imageAsset,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),

          // Overlay gelap
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.35),
                    Colors.black.withOpacity(0.55),
                  ],
                ),
              ),
            ),
          ),

          // Teks di atas gambar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.place, size: 16, color: Colors.white),
                    const SizedBox(width: 4),
                    Text(location, style: const TextStyle(color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      dateTimeText,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

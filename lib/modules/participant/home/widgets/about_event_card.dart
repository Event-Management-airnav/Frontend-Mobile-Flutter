import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutEventCard extends StatelessWidget {
  final Widget titleWidget;
  final bool isRegistered;
  final String description;
  final VoidCallback? onRegister;
  final VoidCallback onShareWhatsapp;
  final VoidCallback onShareFacebook;
  final VoidCallback onCopyLink;
  final Color primaryColor;
  final Color secondaryColor;
  final String registerButtonText;

  const AboutEventCard({
    super.key,
    required this.isRegistered,
    required this.titleWidget,
    required this.description,
    required this.onRegister,
    required this.onShareWhatsapp,
    required this.onShareFacebook,
    required this.onCopyLink,
    this.primaryColor = const Color(0xFF005EA2),
    this.secondaryColor = const Color(0xff075f47),
    required this.registerButtonText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            titleWidget,
            const SizedBox(height: 12),
            Text(
              description,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onRegister,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isRegistered ? secondaryColor : primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  registerButtonText,
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Bagikan Event',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: onCopyLink,
                  icon: const FaIcon(FontAwesomeIcons.copy),
                ),
                IconButton(
                  onPressed: onShareWhatsapp,
                  icon: const FaIcon(
                    FontAwesomeIcons.whatsapp,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 4),
                IconButton(
                  onPressed: onShareFacebook,
                  icon: const FaIcon(
                    FontAwesomeIcons.facebook,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 4),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

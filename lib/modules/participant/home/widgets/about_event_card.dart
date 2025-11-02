import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/utils.dart';

class AboutEventCard extends StatelessWidget {
  final Widget titleWidget;
  final bool isRegistered;
  final String description;
  final VoidCallback? onRegister;
  final Color primaryColor;
  final Color secondaryColor;
  final String registerButtonText;

  ///(contoh: https://airnav-event.vercel.app/user/event/21)
  final String shareUrl;


  final String? shareMessage;

  const AboutEventCard({
    super.key,
    required this.isRegistered,
    required this.titleWidget,
    required this.description,
    required this.onRegister,
    required this.registerButtonText,
    required this.shareUrl,
    this.shareMessage,
    this.primaryColor = const Color(0xFF005EA2),
    this.secondaryColor = const Color(0xff075f47),
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
                  tooltip: 'Salin Link',
                  onPressed: () => _copyLink(context),
                  icon: const FaIcon(FontAwesomeIcons.copy),
                ),
                IconButton(
                  tooltip: 'Bagikan ke WhatsApp',
                  onPressed: _shareToWhatsApp,
                  icon: const FaIcon(
                    FontAwesomeIcons.whatsapp,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 4),
                IconButton(
                  tooltip: 'Bagikan ke Facebook',
                  onPressed: _shareToFacebook,
                  icon: const FaIcon(
                    FontAwesomeIcons.facebook,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 4),
                IconButton(
                  tooltip: 'Bagikan ke X',
                  onPressed: _shareToX,
                  icon: const FaIcon(
                    FontAwesomeIcons.xTwitter,
                    color: Colors.black,
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }



  void _copyLink(BuildContext context) async {
    final link = shareUrl.trim();
    if (link.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: link));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Link disalin')),
    );
  }

  void _shareToWhatsApp() {
    final link = shareUrl.trim();
    if (link.isEmpty) return;
    final message = (shareMessage?.trim().isNotEmpty ?? false)
        ? '${shareMessage!.trim()} $link'
        : link;
    final waUrl = 'https://wa.me/?text=${Uri.encodeComponent(message)}';

    Utils.openUrl(waUrl);
  }

  void _shareToFacebook() {
    final link = shareUrl.trim();
    if (link.isEmpty) return;

    final message = (shareMessage?.trim().isNotEmpty ?? false)
        ? shareMessage!.trim()
        : link;

    final fbUrl =
        'https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeComponent(link)}&quote=${Uri.encodeComponent(message)}';

    Utils.openUrl(fbUrl);
  }


  void _shareToX() {
    final link = shareUrl.trim();
    if (link.isEmpty) return;

    final message = (shareMessage?.trim().isNotEmpty ?? false)
        ? shareMessage!.trim()
        : '';

    final xUrl =
        'https://twitter.com/intent/tweet?text=${Uri.encodeComponent(message)}&url=${Uri.encodeComponent(link)}';

    Utils.openUrl(xUrl);
  }

}

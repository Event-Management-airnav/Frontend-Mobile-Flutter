import 'package:flutter/material.dart';

class SuccessRegister extends StatelessWidget {
  final String title;
  final String subtitle;

  const SuccessRegister({
    super.key,
    this.title = 'SUCCESS',
    this.subtitle = 'Pendaftaran Berhasil',
  });

  /// Tampilkan dialog
  static Future<void> show(
    BuildContext context, {
    String title = 'SUCCESS',
    String subtitle = 'Pendaftaran Berhasil',
  }) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        backgroundColor: Colors.transparent,
        child: SuccessRegister(title: title, subtitle: subtitle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF22C55E);
    const greyText = Color(0xFF6B7280);

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Tombol close di pojok kanan atas
            Row(
              children: [
                const Spacer(),
                InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => Navigator.of(context).pop(),
                  child: const Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.close, size: 22),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),

            // Lingkaran hijau + centang
            Container(
              width: 82,
              height: 82,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: green,
              ),
              child: const Icon(Icons.check, size: 44, color: Colors.white),
            ),

            const SizedBox(height: 16),

            // SUCCESS
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: green,
                fontSize: 24,
                fontWeight: FontWeight.w800,
                letterSpacing: .5,
              ),
            ),

            const SizedBox(height: 8),

            // Subteks
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: greyText,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

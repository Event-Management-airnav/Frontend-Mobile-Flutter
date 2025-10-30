import 'package:flutter/material.dart';

class FailRegister extends StatelessWidget {
  final String title;
  final String subtitle;

  const FailRegister({
    super.key,
    this.title = 'FAILED',
    this.subtitle = 'Pendaftaran Gagal',
  });

  /// Tampilkan dialog gagal
  static Future<void> show(
    BuildContext context, {
    String title = 'FAILED',
    String subtitle = 'Pendaftaran Gagal',
  }) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        backgroundColor: Colors.transparent,
        child: FailRegister(title: title, subtitle: subtitle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const red = Color(0xFFEF4444);
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

            // Lingkaran merah + ikon close
            Container(
              width: 82,
              height: 82,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: red,
              ),
              child: const Icon(
                Icons.close_rounded,
                size: 44,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 16),

            // FAILED
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: red,
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

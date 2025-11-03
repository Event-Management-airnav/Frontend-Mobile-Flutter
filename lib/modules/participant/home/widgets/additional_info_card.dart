import 'package:flutter/material.dart';
import '../../../../core/utils.dart';

class AdditionalInfoCard extends StatelessWidget {
  final String title;
  final List<String> contentLines;
  const AdditionalInfoCard({
    super.key,
    required this.title,
    required this.contentLines,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            _buildRichText(),
          ],
        ),
      ),
    );
  }

  Widget _buildRichText() {
    if (contentLines.isEmpty) return const SizedBox.shrink();

    final text = contentLines.join('\n');

    final regex = RegExp(r'(https?://[^\s]+)');
    String? url;
    final match = regex.firstMatch(text);
    if (match != null) {
      url = match.group(0);
    }

    return GestureDetector(
      onTap: () {
        if (url != null) {
          Utils.openUrl(url);
        }
      },
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: url != null ? Colors.blue : Colors.black,
          decoration: url != null ? TextDecoration.underline : TextDecoration.none,
        ),
      ),
    );
  }
}

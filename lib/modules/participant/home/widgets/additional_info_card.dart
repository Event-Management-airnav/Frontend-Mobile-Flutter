import 'package:flutter/material.dart';

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
    final first = contentLines.first;
    final rest = contentLines.skip(1).toList();

    return Text.rich(
      TextSpan(
        text: '$first ',
        style: const TextStyle(fontWeight: FontWeight.w500),
        children: [TextSpan(text: '\n${rest.join('\n')}')],
      ),
    );
  }
}

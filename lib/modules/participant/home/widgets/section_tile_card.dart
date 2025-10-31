import 'package:flutter/material.dart';

class SectionTileCard extends StatelessWidget {
  final IconData leadingIcon;
  final Color iconColor;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const SectionTileCard({
    super.key,
    required this.leadingIcon,
    required this.iconColor,
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(leadingIcon, color: iconColor),
        title: Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}

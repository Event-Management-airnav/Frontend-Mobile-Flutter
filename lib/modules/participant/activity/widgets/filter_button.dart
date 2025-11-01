import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Icon icon;
  final String text;
  final bool isSelected;

  const FilterButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color bg = isSelected ? Colors.blue : const Color(0xFFEBFAFF);
    final Color fg = isSelected ? Colors.white : Colors.black;

    return ElevatedButton.icon(
      icon: Icon(icon.icon, color: fg), // icon ikut FG
      onPressed: onPressed,
      label: Text(
        text,
        style: TextStyle(
          color: fg,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: bg,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

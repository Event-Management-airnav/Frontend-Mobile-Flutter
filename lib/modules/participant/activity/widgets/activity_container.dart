import 'package:flutter/material.dart';

class ActivityContainer extends StatelessWidget {
  final String eventName;
  final String eventDate;
  final String status;
  final VoidCallback? onTap;
  final VoidCallback? onActionTap;

  const ActivityContainer({
    super.key,
    required this.eventName,
    required this.eventDate,
    required this.status,
    this.onTap,
    this.onActionTap,
  });

  bool get _isSelesai => status.toLowerCase() == 'selesai';

  @override
  Widget build(BuildContext context) {
    const borderBlue = Color(0xFF9ED1F5);
    const headerBlue = Color(0xFFDDF3FF);
    const darkBlue = Color(0xFF10498D);

    final Color statusBg = _isSelesai
        ? const Color(0xFFEFFFF9) // hijau lembut
        : const Color(0xFFFFF6E0); // kuning lembut
    final Color statusText = _isSelesai
        ? const Color(0xFF049E67) // hijau teks
        : const Color(0xFFD79A00); // kuning teks
    final Color dotColor =
        _isSelesai ? const Color(0xFF02C26A) : const Color(0xFF9AA3AF);
    final Color buttonBg =
        _isSelesai ? const Color(0xFF175FA4) : const Color(0xFFD1D5DB);
    final Color buttonFg = _isSelesai ? Colors.white : Colors.black;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: borderBlue, width: 1.5),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ===== Header biru =====
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: headerBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          eventName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: darkBlue,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        eventDate,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: darkBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                // ===== Bawah =====
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Status:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF7A869A),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // chip status
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: statusBg,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: statusText,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // bulatan hijau/abu
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: dotColor,
                      ),
                    ),

                    // tombol kanan
                    SizedBox(
                      width: 140,
                      height: 45,
                      child: TextButton.icon(
                        onPressed: onActionTap,
                        icon: Icon(
                          _isSelesai ? Icons.download : Icons.qr_code_scanner,
                          color: buttonFg,
                        ),
                        label: Text(
                          _isSelesai ? 'Sertifikat' : 'Scan',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: buttonFg,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: buttonBg,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

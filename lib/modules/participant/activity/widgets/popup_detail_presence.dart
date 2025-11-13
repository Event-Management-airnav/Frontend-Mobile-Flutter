// popup_detail_presence_responsive.dart
import 'package:flutter/material.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum PresenceStatus { present, absent, disabled }

class PopupDetailPresence extends StatefulWidget {
  final List<PresenceStatus> statusPerSession;
  final String title;

  const PopupDetailPresence({
    super.key,
    required this.statusPerSession,
    this.title = 'Presensi Sesi Acara',
  });

  @override
  State<PopupDetailPresence> createState() => _PopupDetailPresenceState();
}

class _PopupDetailPresenceState extends State<PopupDetailPresence> {
  int activeStep = 0;

  Widget _buildStepIcon(PresenceStatus status, int index) {
    const double size = 36;
    switch (status) {
      case PresenceStatus.present:
        return CircleAvatar(
          radius: size / 2,
          backgroundColor: Colors.green,
          child: const Icon(Icons.check, color: Colors.white, size: 18),
        );
      case PresenceStatus.absent:
        return CircleAvatar(
          radius: size / 2,
          backgroundColor: Colors.red,
          child: const Icon(Icons.close, color: Colors.white, size: 18),
        );
      case PresenceStatus.disabled:
      default:
        return CircleAvatar(
          radius: size / 2,
          backgroundColor: Colors.grey.shade300,
          child: Icon(Icons.circle, color: Colors.grey.shade400, size: 12),
        );
    }
  }

  Color _getLineColor(int index) {
    if (index >= widget.statusPerSession.length - 1) {
      return Colors.grey.shade300;
    }

    final currentStatus = widget.statusPerSession[index];
    final nextStatus = widget.statusPerSession[index + 1];

    // Garis hijau jika kedua sesi hadir
    if (currentStatus == PresenceStatus.present &&
        nextStatus == PresenceStatus.present) {
      return Colors.green;
    }

    // Garis merah jika ada yang absent
    if (currentStatus == PresenceStatus.absent ||
        nextStatus == PresenceStatus.absent) {
      return Colors.red.shade300;
    }

    return Colors.grey.shade300;
  }

  TextStyle _getTitleStyle(PresenceStatus status) {
    switch (status) {
      case PresenceStatus.present:
        return const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        );
      case PresenceStatus.absent:
        return const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        );
      case PresenceStatus.disabled:
      default:
        return TextStyle(
          color: Colors.grey.shade400,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final statuses = widget.statusPerSession;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ),
            const SizedBox(height: 16),

            // EasyStepper - otomatis responsive!
            EasyStepper(
              activeStep: activeStep,
              stepRadius: 20,
              stepBorderRadius: 0,
              borderThickness: 0,
              padding: const EdgeInsets.all(8),
              showLoadingAnimation: false,
              enableStepTapping: true,
              disableScroll: true,
              fitWidth: true,
              steps: List.generate(
                statuses.length,
                    (index) {
                  final status = statuses[index];
                  return EasyStep(
                    customStep: _buildStepIcon(status, index),
                    title: 'Sesi ${index + 1}',
                    lineText: '',
                    enabled: status != PresenceStatus.disabled,
                    customTitle: Text(
                      'Sesi ${index + 1}',
                      style: _getTitleStyle(status),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
              onStepReached: (index) {
                if (statuses[index] != PresenceStatus.disabled) {
                  setState(() => activeStep = index);
                }
              },
            ),

            const SizedBox(height: 20),

            // Legend
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _legendItem(Colors.green, Icons.check, 'Hadir'),
                _legendItem(Colors.red, Icons.close, 'Tidak Hadir'),
                _legendItem(Colors.grey.shade300, Icons.circle, 'Belum'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _legendItem(Color bgColor, IconData icon, String label) {
    return Row(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: bgColor,
          child: Icon(icon, size: 14, color: Colors.white),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:frontend_mobile_flutter/data/models/event/presence.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/activity_controller.dart';

import '../../../../data/models/event/scan_response.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final ActivityController c = Get.find<ActivityController>();
  final MobileScannerController _scanner = MobileScannerController(
    facing: CameraFacing.back,
    formats: [BarcodeFormat.qrCode],
    detectionSpeed: DetectionSpeed.noDuplicates
  );
  bool _handled = false;

  @override
  void dispose() {
    _scanner.dispose();
    super.dispose();
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_handled) return;
    final code = capture.barcodes.first.rawValue;
    if (code == null || code.isEmpty) return;

    setState(() => _handled = true);
    await _scanner.stop();

    final payload = Presence(kode: code);
    try {
      final ScanResponse res = await c.submitPresence(payload);
      final ok = res.status;
      final msg = res.message.isNotEmpty
          ? res.message
          : (ok ? 'Presensi berhasil' : 'Presensi gagal');

      Get.snackbar(
        'Presensi', msg,
        backgroundColor: ok ? const Color(0xFFEFFFF9) : const Color(0xFFFFF1F0),
        colorText: ok ? const Color(0xFF049E67) : const Color(0xFFB42318),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );

      // success: close; gagal: bisa scan lagi (opsional)
      if (ok) {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) Get.back(result: ok);
        });
      } else {
        if (mounted) {
          await _scanner.start();
          setState(() => _handled = false);
        }
      }
    } catch (e) {
      Get.snackbar(
        'Presensi', 'Gagal memproses: $e',
        backgroundColor: const Color(0xFFFFF1F0),
        colorText: const Color(0xFFB42318),
        snackPosition: SnackPosition.BOTTOM,
      );
      if (mounted) {
        await _scanner.start();
        setState(() => _handled = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Presensi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () => _scanner.toggleTorch(),
          ),
          IconButton(
            icon: const Icon(Icons.cameraswitch),
            onPressed: () => _scanner.switchCamera(),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: _scanner,
            onDetect: _onDetect,
          ),
          // optional overlay sederhana
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

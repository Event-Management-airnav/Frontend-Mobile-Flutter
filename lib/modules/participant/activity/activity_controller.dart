// lib/modules/participant/activity/activity_controller.dart
import 'package:get/get.dart';
import 'package:frontend_mobile_flutter/data/network/services/followed_services.dart';
import 'package:frontend_mobile_flutter/data/models/event/followed_event.dart';
import 'package:frontend_mobile_flutter/data/models/event/presence.dart';

class ActivityController extends GetxController {
  final FollowedServices service = Get.find<FollowedServices>();

  final isLoading = false.obs;
  final error = RxnString();
  final followedEvents = <Datum>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFollowed();
  }

  Future<void> loadFollowed({int page = 1}) async {
    try {
      isLoading.value = true;
      error.value = null;

      final list = await service.getFollowedEvents(page: page);
      if (page == 1) {
        followedEvents.assignAll(list);
      } else {
        followedEvents.addAll(list);
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshFollowed() => loadFollowed(page: 1);

  Future<Map<String, dynamic>> submitPresence(Presence payload) async {
    try {
      isLoading.value = true;
      error.value = null;
      final res = await service.sendPresence(payload);
      return res;
    } catch (e) {
      error.value = e.toString();
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  // ===== Helpers untuk UI =====
  String eventNameOf(Datum d) => d.modulAcara?.mdlNama ?? '-';

  /// Ambil tanggal acara (prioritas mulai acara; fallback ke waktu daftar)
  DateTime? eventDateOf(Datum d) =>
      d.modulAcara?.mdlAcaraMulai ?? d.waktuDaftar;

  String statusOf(Datum d) => d.modulAcara?.mdlStatus ?? '-';

  /// Format sederhana: 29 Oct 2025 (tanpa dependensi `intl`)
  String formatDate(DateTime? dt) {
    if (dt == null) return '-';
    const months = [
      'Jan','Feb','Mar','Apr','May','Jun',
      'Jul','Aug','Sep','Oct','Nov','Dec'
    ];
    return '${dt.day.toString().padLeft(2, '0')} ${months[dt.month - 1]} ${dt.year}';
    // kalau kamu pakai package:intl:
    // return DateFormat('dd MMM yyyy', 'id_ID').format(dt);
  }
}

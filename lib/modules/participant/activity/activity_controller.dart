// lib/modules/participant/activity/activity_controller.dart
import 'package:get/get.dart';
import 'package:frontend_mobile_flutter/data/network/services/followed_services.dart';
import 'package:frontend_mobile_flutter/data/models/event/followed_event.dart';
import 'package:frontend_mobile_flutter/data/models/event/presence.dart';

import '../../../core/utils.dart';


class ActivityController extends GetxController {
  final FollowedServices service = Get.find<FollowedServices>();
  final _utils = Utils();

  final isLoading = false.obs;
  final error = RxnString();
  final followedEvents = <Datum>[].obs;
  final selectedFilter = Rxn<ActivityFilter>();

  @override
  void onInit() {
    super.onInit();
    loadFollowed();
  }

  void selectFilter(ActivityFilter f) {
    if (selectedFilter.value == f) {
      selectedFilter.value = null;
    } else {
      selectedFilter.value = f;
    }
  }

  List<Datum> get filteredFollowed {
    final f = selectedFilter.value;
    if (f == null) return followedEvents;

    return followedEvents.where((d) {
      final s = d.modulAcara?.mdlStatus?.toLowerCase();
      if (f == ActivityFilter.selesai) return s == 'selesai' || s == 'closed';
      if (f == ActivityFilter.berlangsung) return s == 'active' || s == 'ongoing';
      return true;
    }).toList();
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

  // ===== Helpers untuk UI (pakai Utils) =====

  /// Nama event atau '-'
  String eventNameOf(Datum d) => d.modulAcara?.mdlNama ?? '-';

  /// Ambil tanggal event: prioritas mulai acara; fallback ke waktu daftar.
  /// Selalu parse via Utils.toDateTimeFlexible agar aman kalau tipe berubah (String/DateTime).
  DateTime? eventDateOf(Datum d) {
    final mulai = d.modulAcara?.mdlAcaraMulai; // bisa DateTime? (model baru) atau null
    if (mulai is DateTime) return mulai;
    if (mulai != null) {
      // jika suatu saat tipe berubah jadi String
      final parsed = _utils.toDateTimeFlexible(mulai.toString());
      if (parsed != null) return parsed;
    }

    final daftar = d.waktuDaftar;
    if (daftar is DateTime) return daftar;
    if (daftar != null) {
      return _utils.toDateTimeFlexible(daftar.toString());
    }
    return null;
  }

  /// Status event atau '-'
  String statusOf(Datum d) => d.modulAcara?.mdlStatus ?? '-';

  /// Format sederhana: 29 Oct 2025 (tanpa intl)
  String formatDate(DateTime? dt) {
    if (dt == null) return '-';
    const months = [
      'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'
    ];
    return '${dt.day.toString().padLeft(2, '0')} ${months[dt.month - 1]} ${dt.year}';
  }
}

enum ActivityFilter { selesai, berlangsung }

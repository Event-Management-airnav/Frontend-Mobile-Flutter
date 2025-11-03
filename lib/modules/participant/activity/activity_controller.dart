import 'package:frontend_mobile_flutter/data/models/event/event_detail.dart';
import 'package:get/get.dart';
import 'package:frontend_mobile_flutter/data/network/services/activity_service.dart';
import 'package:frontend_mobile_flutter/data/models/event/followed_event.dart';
import 'package:frontend_mobile_flutter/data/models/event/presence.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/utils.dart';
import '../../../data/models/event/scan_response.dart';


class ActivityController extends GetxController {
  final ActivityService service = Get.find<ActivityService>();
  final _utils = Utils();
  final _storage = GetStorage();

  final isLoggedIn = false.obs;
  final isLoading = false.obs;
  final error = RxnString();
  final followedEvents = <Datum>[].obs;
  final selectedFilter = Rxn<ActivityFilter>();

  @override
  void onInit() {
    super.onInit();

    _storage.listenKey('access_token', (value) {
      checkLoginStatus();
    });
    checkLoginStatus();

    if (isLoggedIn.value) {
      loadFollowed();
    }
  }
  void checkLoginStatus() {
    final token = _storage.read('access_token');
    isLoggedIn.value = token != null && token.isNotEmpty;
  }

  void selectFilter(ActivityFilter f) {
    if (selectedFilter.value == f) {
      selectedFilter.value = null;
    } else {
      selectedFilter.value = f;
    }
  }

  /// Safely parse a date that can be a String, DateTime, or null.
  DateTime? _parseDate(dynamic date) {
    if (date == null) return null;
    if (date is DateTime) return date;
    if (date is String) {
      try {
        return DateTime.parse(date);
      } catch (_) {
        return null; // Return null if parsing fails
      }
    }
    return null;
  }

  List<Datum> get filteredFollowed {
    final f = selectedFilter.value;
    if (f == null) return followedEvents.toList();

    final now = DateTime.now();

    return followedEvents.where((d) {
      return eventStatus(d) == f;
      // // Assumes `modulAcara` has `mdlAcaraMulai` and `mdlAcaraSelesai` fields,
      // // similar to the Acara object in event_detail.dart.
      // final startTime = _parseDate(d.modulAcara?.mdlAcaraMulai);
      // final endTime = _parseDate(d.modulAcara?.mdlAcaraSelesai);
      //
      // switch (f) {
      //   case ActivityFilter.mendatang:
      //     if (startTime == null) return false;
      //     return startTime.isAfter(now);
      //   case ActivityFilter.berlangsung:
      //     if (startTime == null) return false;
      //     // Event is ongoing if it started and has not ended.
      //     // If no end time, it's considered ongoing forever after it starts.
      //     return startTime.isBefore(now) && (endTime == null || endTime.isAfter(now));
      //   case ActivityFilter.selesai:
      //     // Event is finished only if an end time is specified and it's in the past.
      //     if (endTime == null) return false;
      //     return endTime.isBefore(now);
      // }
    }).toList();
  }


  ActivityFilter eventStatus(Datum d) {
    final startTime = _parseDate(d.modulAcara?.mdlAcaraMulai);
    final endTime = _parseDate(d.modulAcara?.mdlAcaraSelesai);
    final now = DateTime.now();

    if (startTime == null) return ActivityFilter.selesai;

    if (startTime.isAfter(now)) return ActivityFilter.mendatang;
    if (endTime == null || endTime.isAfter(now)) return ActivityFilter.berlangsung;
    return ActivityFilter.selesai;

    // switch (f) {
    //   case ActivityFilter.mendatang:
    //     if (startTime == null) return false;
    //     return startTime.isAfter(now);
    //   case ActivityFilter.berlangsung:
    //     if (startTime == null) return false;
    //     // Event is ongoing if it started and has not ended.
    //     // If no end time, it's considered ongoing forever after it starts.
    //     return startTime.isBefore(now) && (endTime == null || endTime.isAfter(now));
    //   case ActivityFilter.selesai:
    //   // Event is finished only if an end time is specified and it's in the past.
    //     if (endTime == null) return false;
    //     return endTime.isBefore(now);
    // }
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

  Future<ScanResponse> submitPresence(Presence payload) async {
    try {
      isLoading.value = true;
      error.value = null;
      final res = await service.sendPresence(payload); // <-- ScanResponse
      return res;
    } catch (e) {
      error.value = e.toString();
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }


  /// Nama event atau '-'
  String eventNameOf(Datum d) => d.modulAcara?.mdlNama ?? '-';

  /// Ambil tanggal event: prioritas mulai acara; fallback ke waktu daftar.
  /// Selalu parse via Utils.toDateTimeFlexible agar aman kalau tipe berubah (String/DateTime).
  DateTime? eventDateOf(Datum d) {
    final mulai = d.modulAcara?.mdlAcaraMulai; // bisa DateTime? (model baru) atau null
    if (mulai is DateTime) return mulai;
    final daftar = d.waktuDaftar;
    if (daftar is DateTime) return daftar;
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

enum ActivityFilter { mendatang, berlangsung, selesai }

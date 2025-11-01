// lib/modules/participant/activity/activity_controller.dart
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

    loadFollowed();

    _storage.listenKey('access_token', (value) {
      checkLoginStatus();
    });
    checkLoginStatus();

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

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:frontend_mobile_flutter/data/network/services/activity_service.dart';
import 'package:frontend_mobile_flutter/data/models/event/followed_event.dart';
import 'package:frontend_mobile_flutter/data/models/event/presence.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/logger.dart';
import '../../../core/utils.dart';
import '../../../data/models/certificate/certificate_response.dart';
import '../../../data/models/event/scan_response.dart';

class ActivityController extends GetxController {
  final ActivityService service = Get.find<ActivityService>();
  final _storage = Get.find<GetStorage>();

  var timeNow = DateTime.now().obs;
  final RxBool isLoggedIn = false.obs;
  final RxBool isLoading = false.obs;
  final error = RxnString();
  final followedEvents = <Datum>[].obs;
  final selectedFilter = Rxn<ActivityFilter>();
  final searchQuery = ''.obs;

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

  Future<CertificateResponse?> getCertificateForEvent(int eventId) async {
    try {
      timeNow.value = DateTime.now();
      error.value = null;

      final CertificateResponse res = await service.getCertificate(eventId);

      if (!res.status) {
        error.value = res.message;
      }

      if (kDebugMode) {
        print("urlSertifikat (controller): ${res.data}");
      }
      return res;
    } catch (e) {
      error.value = e.toString();
      rethrow;
    }
  }




  void updateSearchQuery(String query) {
    searchQuery.value = query;
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
    final query = searchQuery.value.toLowerCase();
    var events = followedEvents.toList();

    if (f != null) {
      events = events.where((d) => eventStatus(d) == f).toList();
    }

    if (query.isNotEmpty) {
      events = events.where((d) {
        final eventName = d.modulAcara.mdlNama.toLowerCase();
        return eventName.contains(query);
      }).toList();
    }

    return events;
  }


  ActivityFilter eventStatus(Datum d) {
    final startTime = Utils.parseDate(d.modulAcara.mdlAcaraMulai);
    final endTime = Utils.parseDate(d.modulAcara.mdlAcaraSelesai);
    final now = DateTime.now();

    if (startTime == null) return ActivityFilter.selesai;

    if (startTime.isAfter(now)) return ActivityFilter.mendatang;
    if (endTime == null || endTime.isAfter(now)) return ActivityFilter.berlangsung;
    return ActivityFilter.selesai;
  }

  Future<void> loadFollowed({int page = 1}) async {
    if (!isLoggedIn.value) {
      followedEvents.clear();
      return;
    }
    try {
      isLoading.value = true;
      error.value = null;

      final list = await service.getFollowedEvents(page: page);

      if (kDebugMode) {
        debugPrint('followed events list: $list');
      }

      if (page == 1) {
        followedEvents.assignAll(list);
      } else {
        followedEvents.addAll(list);
      }
    } catch (e, stackTrace) {
      logger.e("Error loading followed events", error:e, stackTrace: stackTrace);
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

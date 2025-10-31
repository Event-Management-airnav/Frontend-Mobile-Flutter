import 'package:frontend_mobile_flutter/data/network/services/home_service.dart';
import 'package:get/get.dart';

import '../../../data/models/event/event.dart';

enum HomeFilter { none, active, upcoming, past }

class HomeController extends GetxController {
  final service = Get.find<HomeService>();

  final isLoading = false.obs;

  // Cached lists in controller (backed by service cache too)
  final allEvents = <Event>[].obs;
  final activeEvents = <Event>[].obs;
  final upcomingEvents = <Event>[].obs;
  final pastEvents = <Event>[].obs;

  // current active chip index: null (none) => show all
  final Rxn<HomeFilter> activeFilter = Rxn<HomeFilter>(null);

  @override
  void onInit() {
    super.onInit();
    _loadAll(); // strategy B: fetch once on init
  }

  Future<void> _loadAll() async {
    try {
      isLoading.value = true;

      final a = await service.fetchAllEvents();
      final b = await service.fetchActiveEvents();
      final c = await service.fetchUpcomingEvents();
      final d = await service.fetchPastEvents();

      allEvents.assignAll(a);
      activeEvents.assignAll(b);
      upcomingEvents.assignAll(c);
      pastEvents.assignAll(d);
    } catch (e) {
      Get.snackbar("Error loading data", "An unexpected error occurred: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  /// Toggle filter chips. If same filter tapped twice -> deactivate (null -> show ALL)
  void toggleFilter(HomeFilter filter) {
    if (activeFilter.value == filter) {
      activeFilter.value = null; // show all
    } else {
      activeFilter.value = filter;
    }
  }

  /// Returns the current visible list based on activeFilter (null => all)
  List<Event> get visibleEvents {
    final f = activeFilter.value;
    if (f == null) return allEvents;
    switch (f) {
      case HomeFilter.active:
        return activeEvents;
      case HomeFilter.upcoming:
        return upcomingEvents;
      case HomeFilter.past:
        return pastEvents;
      case HomeFilter.none:
      default:
        return allEvents;
    }
  }
}

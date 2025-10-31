import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../models/event/event.dart';
import '../api_client.dart';
import '../endpoints.dart';

class HomeService extends GetxService {
  // Simple in-memory cache keyed by endpoint name
  final Map<String, List<Event>> _cache = {};

  Future<List<Event>> _fetchEvents(String endpoint, String cacheKey) async {
    // Return cached if present
    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey]!;
    }

    try {
      final resp = await ApiClient.dio.get(endpoint);

      // Strict: data.events must exist
      final payload = resp.data;
      final eventsJson = payload["data"]["events"] as List<dynamic>;

      final events = eventsJson.map((e) {
        return Event.fromJson(e as Map<String, dynamic>);
      }).toList();

      // Cache it
      _cache[cacheKey] = events;
      return events;
    } on DioException catch (e) {
      Get.snackbar("Network Error", e.message ?? "Failed to load events");
      return <Event>[];
    } catch (e) {
      Get.snackbar("Error", "Unexpected error while parsing dashboard data");
      return <Event>[];
    }
  }

  Future<List<Event>> fetchAllEvents() =>
      _fetchEvents(Endpoints.eventsAll, 'all');

  Future<List<Event>> fetchActiveEvents() =>
      _fetchEvents(Endpoints.events, 'active');

  Future<List<Event>> fetchUpcomingEvents() =>
      _fetchEvents(Endpoints.eventsUpcoming, 'upcoming');

  Future<List<Event>> fetchPastEvents() =>
      _fetchEvents(Endpoints.eventsPast, 'past');

  /// Optional: clear cache (for manual refresh or testing)
  void clearCache() => _cache.clear();
}
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../models/event/event_detail.dart';
import '../api_client.dart';
import '../endpoints.dart';

class EventDetailService extends GetxService {
  Future<EventDetail?> getEventDetail(int id) async {
    try {
      final response = await ApiClient.dio.get('${Endpoints.eventDetail}/$id');

      if (response.data == null) {
        return null;
      }

      final data = EventDetailResponse.fromJson(response.data);
      // Use null-safe access to prevent errors if parts of the response are null
      return data.data?.event;
    } on DioException catch (e) {
      // Throw a proper exception instead of a string
      final errorMessage = e.response?.data?['message'] as String? ?? 'Failed to retrieve event detail';
      throw Exception(errorMessage);
    } catch (e) {
      // Handle other potential errors gracefully
      throw Exception('An unexpected error occurred. Please try again.');
    }
  }
}

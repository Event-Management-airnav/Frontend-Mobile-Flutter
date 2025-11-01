import 'package:get/get.dart' hide Response;
import 'package:dio/dio.dart';

import 'package:frontend_mobile_flutter/data/network/api_client.dart';
import 'package:frontend_mobile_flutter/data/network/endpoints.dart';
import 'package:frontend_mobile_flutter/data/models/event/followed_event.dart';
import 'package:frontend_mobile_flutter/data/models/event/presence.dart';

class FollowedServices extends GetxService {
  final Dio _client = ApiClient.dio;

  /// GET daftar event yg diikuti
  Future<List<Datum>> getFollowedEvents({int page = 1}) async {
    try {
      final Response res = await _client.get(
        Endpoints.followedEvents,
        queryParameters: {'page': page},
      );

      final wrapped = FollowedEvent.fromJson(res.data as Map<String, dynamic>);
      return wrapped.data?.data ?? <Datum>[];
    } on DioException catch (e) {
      throw Exception(_msg(e, 'Gagal memuat events yang diikuti'));
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  /// POST presensi -> payload Presence model
  Future<Map<String, dynamic>> sendPresence(Presence data) async {
    try {
      final Response res = await _client.post(
        Endpoints.presence,
        data: data.toJson(),
      );
      return res.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw Exception(_msg(e, 'Gagal mengirim presensi'));
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  String _msg(DioException e, String fallback) {
    final data = e.response?.data;
    if (data is Map && data['message'] != null) return data['message'].toString();
    return fallback;
  }
}

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../models/pendaftaran/my_registration.dart';
import '../../models/pendaftaran/pendaftaran_response.dart';
import '../api_client.dart';
import '../endpoints.dart';

class PendaftaranService extends GetxService {
  final Dio _dio = ApiClient.dio;

  Future<PendaftaranResponse?> daftarEvent(int eventId) async {
    try {
      final resp = await _dio.post("${Endpoints.events}/$eventId/daftar");
      return PendaftaranResponse.fromJson(resp.data);
    } on DioException catch (e) {
      return PendaftaranResponse(
        success: false,
        message: e.response?.data["message"] ?? "Failed to register",
      );
    }
  }

  Future<List<MyRegistration>> fetchMyEvents() async {
    try {
      final resp = await _dio.get(Endpoints.followedEvents);

      final list = (resp.data["data"]["data"] as List<dynamic>)
          .map((e) => MyRegistration.fromJson(e))
          .toList();

      return list;
    } catch (_) {
      return [];
    }
  }

  Future<MyRegistration?> fetchMyEventDetail(int eventId) async {
    try {
      final resp = await _dio.get("${Endpoints.events}/$eventId/me");
      return MyRegistration.fromJson(resp.data["data"]);
    } catch (_) {
      return null;
    }
  }

  Future<bool> isRegistered(int eventId) async {
    try {
      final resp = await _dio.get("${Endpoints.events}/$eventId/me");
      return resp.data["success"] == true;
    } catch (_) {
      return false;
    }
  }

}

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../models/auth/register_request.dart';
import '../../models/auth/register_response.dart';
import '../api_client.dart';
import '../endpoints.dart';

class AuthService extends GetxService {
  final storage = GetStorage();
  final secure = const FlutterSecureStorage();

  Future<RegisterResponse> register(RegisterRequest req) async {
    try {
      final response = await ApiClient.dio.post(
        Endpoints.register,
        data: req.toJson(),
      );

      return RegisterResponse.fromJson(response.data);
    } on DioException catch (e) {
      final res = e.response?.data;

      return RegisterResponse(
        success: false,
        message: res?["message"] ?? "Registration failed",
        errors: res?["errors"],
      );
    }
  }
}
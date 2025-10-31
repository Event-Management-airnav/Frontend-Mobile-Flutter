import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../models/auth/login_request.dart';
import '../../models/auth/login_response.dart';
import '../../models/auth/register_request.dart';
import '../../models/auth/register_response.dart';
import '../api_client.dart';
import '../endpoints.dart';

class AuthService extends GetxService {
  final storage = GetStorage();
  final secure = const FlutterSecureStorage();

  Future<LoginResponse> login(LoginRequest req) async {
    try {
      final response = await ApiClient.dio.post(
        Endpoints.login,
        data: req.toJson(),
      );

      final model = LoginResponse.fromJson(response.data);

      if (model.success && model.data != null) {
        await secure.write(
          key: "access_token",
          value: model.data!.accessToken,
        );

        storage.write("name", model.data!.user.name);
        storage.write("username", model.data!.user.username);
        storage.write("role", model.data!.user.role);
        storage.write("email", model.data!.user.email);
      }

      return model;
    } on DioException catch (e) {
      final body = e.response?.data;

      return LoginResponse(
        success: false,
        message: body?["message"] ?? "Login failed",
      );
    }
  }

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
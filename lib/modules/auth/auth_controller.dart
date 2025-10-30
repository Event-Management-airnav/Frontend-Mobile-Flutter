import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import 'package:frontend_mobile_flutter/data/network/api_services.dart';
import 'package:frontend_mobile_flutter/data/models_test/auth/register_model.dart';

class AuthController extends GetxController {
  final ApiService _api = Get.find<ApiService>();

  /// state reactive (opsional buat UI)
  final isLoading = false.obs;
  final errorMessage = RxnString();

  /// Register user, hasilnya langsung `RegisterModel`
  Future<RegisterModel?> registerUser(RegisterModel user) async {
    try {
      isLoading.value = true;
      errorMessage.value = null;

      final res = await _api.register(user);

      if (res.statusCode == 200 || res.statusCode == 201) {
        return RegisterModel.fromJson(res.data);
      } else {
        errorMessage.value = 'Register gagal (${res.statusCode})';
        return null;
      }
    } on dio.DioException catch (e) {
      errorMessage.value = e.message ?? 'Terjadi kesalahan jaringan';
      return null;
    } catch (e) {
      errorMessage.value = 'Terjadi kesalahan: $e';
      return null;
    } finally {
      isLoading.value = false;
    }
  }
}

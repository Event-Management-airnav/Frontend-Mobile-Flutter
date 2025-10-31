import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:frontend_mobile_flutter/data/models_test/auth/register_model.dart';

class ApiService extends GetxService {
  late dio.Dio _dio;

  ApiService() {
    _dio = dio.Dio(
      dio.BaseOptions(
        baseUrl: 'https://mediumpurple-swallow-757782.hostingersite.com/api/',
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
      ),
    );
  }

  // Constructor khusus untuk testing
  ApiService.test(dio.Dio dioInstance) {
    _dio = dioInstance;
  }

  /// Sekarang terima RegisterModel, bukan Map
  Future<dio.Response> register(RegisterModel user) async {
    return await _dio.post('register', data: user.toJson());
  }
}

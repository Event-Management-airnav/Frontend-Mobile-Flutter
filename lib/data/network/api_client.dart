import 'package:dio/dio.dart';
import 'package:frontend_mobile_flutter/data/network/api_interceptor.dart';
import 'package:frontend_mobile_flutter/env/env.dart';

class ApiClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: Env.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      responseType: ResponseType.json,
      contentType: "application/json",
    ),
  )..interceptors.add(ApiInterceptor());
}

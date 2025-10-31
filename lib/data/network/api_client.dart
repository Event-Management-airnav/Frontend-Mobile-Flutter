import 'package:dio/dio.dart';
import 'package:frontend_mobile_flutter/data/network/api_interceptor.dart';

class ApiClient {
  static final Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      responseType: ResponseType.json,
      contentType: "application/json",
    ),
  )..interceptors.add(ApiInterceptor());
}
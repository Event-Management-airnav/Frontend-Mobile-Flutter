import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiInterceptor extends Interceptor {
  // final secure = const FlutterSecureStorage();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Use Get.find() to ensure the same instance is used everywhere.
    final storage = Get.find<GetStorage>();
    final token = storage.read("access_token");
    // final token = "92|cbOz59FWbl6Fepvm8KropaEIrKuvIs6GVJPjgdMo50c14b01";


    if (token != null && token.isNotEmpty) {
      options.headers["Authorization"] = "Bearer $token";
    }
    options.headers["Accept"] = "application/json";
    // TODO check if unneeded header returns error

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    final response = err.response;

    if (response != null) {
      switch (response.statusCode) {
        case 400:
          // TODO make sure response data message never null
          Get.snackbar("Bad Request", response.data["message"] ?? "Invalid request");
          break;
        case 401:
          Get.snackbar("Unauthorized", response.data["message"] ?? "Invalid credentials");
          break;
        case 403:
          Get.snackbar("Forbidden", response.data["message"] ?? "Not allowed");
          break;
        case 404:
          Get.snackbar("Not Found", response.data["message"] ?? "Not found");
          break;
        case 422:
          Get.snackbar("Unprocessable Entity", response.data["message"] ?? "Invalid request");
          break;
        case 500:
          Get.snackbar("Internal Server Error", response.data["message"] ?? "Internal server error");
          break;
        default:
          Get.snackbar("Unknown Error", response.data["message"] ?? "Something went wrong");
          break;
      }
    } else {
      Get.snackbar("Connection Error", "Network unavailable");
    }

    handler.next(err);
  }
}

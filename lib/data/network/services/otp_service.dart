import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../models/auth/otp_resend_request.dart';
import '../../models/auth/otp_verify_request.dart';
import '../../models/basic_response.dart';
import '../api_client.dart';
import '../endpoints.dart';

class OtpService extends GetxService {

  Future<BasicResponse> verifyOtp(OtpVerifyRequest req) async {
    try {
      final response = await ApiClient.dio.post(
        Endpoints.verifyOtp,
        data: req.toJson(),
      );

      return BasicResponse.fromJson(response.data);
    } on DioException catch (e) {
      final res = e.response?.data;

      return BasicResponse(
        success: false,
        message: res?["message"] ?? "Verification failed",
      );
    }
  }

  Future<BasicResponse> resendOtp(OtpResendRequest req) async {
    try {
      final response = await ApiClient.dio.post(
        Endpoints.resendOtp,
        data: req.toJson(),
      );

      return BasicResponse.fromJson(response.data);
    } on DioException catch (e) {
      final res = e.response?.data;

      return BasicResponse(
        success: false,
        message: res?["message"] ?? "Resend failed",
      );
    }
  }
}

import 'package:dio/dio.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

import '../../models/basic_response.dart';
import '../../models/profile/change_password_request.dart';
import '../../models/profile/profile_response.dart';
import '../../models/profile/update_profile_request.dart';
import '../api_client.dart';
import '../endpoints.dart';

class ProfileService extends GetxService {

  Future<ProfileResponse> getProfile() async {
    try {
      final res = await ApiClient.dio.get(Endpoints.profile);
      return ProfileResponse.fromJson(res.data);
    } on DioException catch (e) {
      final data = e.response?.data;
      return ProfileResponse(
        success: false,
        message: data?["message"] ?? "Failed to load profile",
      );
    }
  }

  Future<ProfileResponse> updateProfile(UpdateProfileRequest req) async {
    try {
      final form = FormData.fromMap({
        "name": req.name,
        "telp": req.telp,
        if (req.profilePhoto != null)
          "profile_photo": await MultipartFile.fromFile(req.profilePhoto!.path),
      });

      final res = await ApiClient.dio.post(
        Endpoints.profileUpdate,
        data: form,
      );

      return ProfileResponse.fromJson(res.data);

    } on DioException catch (e) {
      final data = e.response?.data;
      return ProfileResponse(
        success: false,
        message: data?["message"] ?? "Update failed",
      );
    }
  }

  Future<BasicResponse> changePassword(ChangePasswordRequest req) async {
    try {
      final res = await ApiClient.dio.post(
        Endpoints.profileChangePassword,
        data: req.toJson(),
      );

      return BasicResponse.fromJson(res.data);

    } on DioException catch (e) {
      final data = e.response?.data;
      return BasicResponse(
        success: false,
        message: data?["message"] ?? "Change password failed",
      );
    }
  }
}
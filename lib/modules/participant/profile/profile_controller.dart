import 'package:get/get.dart';

import '../../../data/models/profile/change_password_request.dart';
import '../../../data/models/profile/profile_model.dart';
import '../../../data/models/profile/update_profile_request.dart';
import '../../../data/network/services/profile_service.dart';

class ProfileController extends GetxController {
  final service = Get.find<ProfileService>();

  final isLoading = false.obs;
  final profile = Rxn<ProfileModel>();
  final message = "".obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      isLoading.value = true;
      final res = await service.getProfile();

      message.value = res.message;
      if (res.success && res.data != null) {
        profile.value = res.data!;
      }

    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile(UpdateProfileRequest req) async {
    try {
      isLoading.value = true;
      final res = await service.updateProfile(req);

      message.value = res.message;
      if (res.success && res.data != null) {
        profile.value = res.data!;
      }

    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changePassword(ChangePasswordRequest req) async {
    try {
      isLoading.value = true;
      final res = await service.changePassword(req);

      message.value = res.message;

    } finally {
      isLoading.value = false;
    }
  }
}

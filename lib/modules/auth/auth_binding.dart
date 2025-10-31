import 'package:get/get.dart';
import 'package:frontend_mobile_flutter/modules/auth/auth_controller.dart';
import 'package:frontend_mobile_flutter/data/network/services/auth_service.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Register AuthService first
    Get.lazyPut<AuthService>(() => AuthService());
    
    // Then register AuthController
    Get.put(AuthController(), permanent: true);
  }
}
import 'package:get/get.dart';
import 'package:frontend_mobile_flutter/modules/auth/auth_controller.dart';
import 'package:frontend_mobile_flutter/data/network/services/auth_service.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Register AuthService as a permanent service to ensure it's always available.
    Get.put<AuthService>(AuthService(), permanent: true);
    
    // Lazily load AuthController for the authentication feature.
    Get.lazyPut<AuthController>(() => AuthController());
  }
}

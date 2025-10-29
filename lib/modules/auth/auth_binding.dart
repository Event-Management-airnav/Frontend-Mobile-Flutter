import 'package:frontend_mobile_flutter/modules/auth/auth_controller.dart';
import 'package:frontend_mobile_flutter/modules/main_container/main_controller.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}

import 'package:frontend_mobile_flutter/modules/participant/profile/profile_controller.dart';
import 'package:frontend_mobile_flutter/modules/test/test_controller.dart';
import 'package:get/get.dart';

class TestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TestController>(() => TestController());
  }
}

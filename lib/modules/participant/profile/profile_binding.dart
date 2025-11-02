import 'package:get/get.dart';

import '../../../data/network/services/profile_service.dart';
import 'profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileService());
    Get.lazyPut(() => ProfileController());
  }
}

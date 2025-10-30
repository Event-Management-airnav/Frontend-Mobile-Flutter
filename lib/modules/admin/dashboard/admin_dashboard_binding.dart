import 'package:frontend_mobile_flutter/modules/participant/profile/profile_controller.dart';
import 'package:get/get.dart';

import 'admin_dashboard_controller.dart';

class AdminDashboardPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminDashboardPageController>(() => AdminDashboardPageController());
  }
}

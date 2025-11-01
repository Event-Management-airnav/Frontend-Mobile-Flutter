import 'package:frontend_mobile_flutter/data/network/services/activity_service.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/activity_controller.dart';
import 'package:frontend_mobile_flutter/modules/participant/profile/profile_controller.dart';
import 'package:get/get.dart';

class ActivityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivityService>(()=> ActivityService());
    Get.lazyPut<ActivityController>(() => ActivityController());
  }
}

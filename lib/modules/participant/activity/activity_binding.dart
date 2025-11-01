import 'package:frontend_mobile_flutter/data/network/services/followed_services.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/activity_controller.dart';
import 'package:frontend_mobile_flutter/modules/participant/profile/profile_controller.dart';
import 'package:get/get.dart';

class ActivityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FollowedServices>(()=> FollowedServices());
    Get.lazyPut<ActivityController>(() => ActivityController());
  }
}

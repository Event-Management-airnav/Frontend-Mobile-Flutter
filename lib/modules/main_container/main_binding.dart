import 'package:frontend_mobile_flutter/modules/main_container/main_controller.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/activity_controller.dart';
import 'package:frontend_mobile_flutter/modules/participant/home/home_controller.dart';
import 'package:frontend_mobile_flutter/modules/participant/profile/profile_controller.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ActivityController>(() => ActivityController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}

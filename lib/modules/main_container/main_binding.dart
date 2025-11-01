import 'package:frontend_mobile_flutter/data/network/services/auth_service.dart';
import 'package:frontend_mobile_flutter/data/network/services/home_service.dart';
import 'package:frontend_mobile_flutter/data/network/services/profile_service.dart';
import 'package:frontend_mobile_flutter/modules/auth/auth_controller.dart';
import 'package:frontend_mobile_flutter/modules/main_container/main_controller.dart';
import 'package:frontend_mobile_flutter/modules/participant/home/home_controller.dart';
import 'package:frontend_mobile_flutter/modules/participant/profile/profile_controller.dart';
import 'package:get/get.dart';

import '../../data/network/services/activity_service.dart';
import '../participant/activity/activity_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<HomeService>(() => HomeService(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<AuthService>(() => AuthService(), fenix: true);
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<ProfileService>(() => ProfileService(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<ActivityService>(()=> ActivityService(), fenix: true);
    Get.lazyPut<ActivityController>(() => ActivityController());

  }
}

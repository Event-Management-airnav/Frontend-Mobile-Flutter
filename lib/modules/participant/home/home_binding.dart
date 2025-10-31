import 'package:frontend_mobile_flutter/data/network/services/home_service.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeService>(() => HomeService(), fenix: true);
    Get.put<HomeController>(HomeController());
  }
}

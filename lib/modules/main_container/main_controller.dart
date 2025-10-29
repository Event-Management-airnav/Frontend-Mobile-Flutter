// lib/modules/main/controllers/main_controller.dart
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainController extends GetxController {
  late final PersistentTabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = PersistentTabController(initialIndex: 0);
  }

  void switchTo(int index) => tabController.index = index;
}

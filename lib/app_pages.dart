import 'package:frontend_mobile_flutter/modules/auth/auth_binding.dart';
import 'package:frontend_mobile_flutter/modules/auth/auth_page.dart';
import 'package:frontend_mobile_flutter/modules/main_container/main_binding.dart';
import 'package:frontend_mobile_flutter/modules/main_container/main_page.dart';
import 'package:frontend_mobile_flutter/modules/participant/home/home_binding.dart';
import 'package:frontend_mobile_flutter/modules/participant/home/home_page.dart';
import 'package:frontend_mobile_flutter/modules/participant/profile/profile_binding.dart';
import 'package:frontend_mobile_flutter/modules/participant/profile/profile_page.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MAIN;

  static final routes = [
    GetPage(
        name: _Paths.AUTH,
        page: () => const AuthPage(),
        binding: AuthBinding()),
    GetPage(
        name: _Paths.MAIN,
        page: () => const MainView(),
        binding: MainBinding()),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
    // GetPage(
    //   name: _Paths.DASHBOARD,
    //   page: () => const DashboardView(),
    //   binding: DashboardBinding(),
    // ),
    // GetPage(
    //   name: _Paths.EVENT,
    //   page: () => const EventView(),
    //   binding: EventBinding(),
    // ),
  ];
}

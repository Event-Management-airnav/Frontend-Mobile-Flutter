import 'package:flutter/material.dart';
import 'package:frontend_mobile_flutter/app_pages.dart';
import 'package:frontend_mobile_flutter/core/app_themes.dart';
import 'package:frontend_mobile_flutter/data/network/api_services.dart';
import 'package:get/get.dart';

void main() {
  Get.put<ApiService>(ApiService());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'NavEvent',
      theme: AppThemes.lightTheme,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}

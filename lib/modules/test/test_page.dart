import 'package:flutter/material.dart';
import 'package:frontend_mobile_flutter/modules/participant/home/home_controller.dart';
import 'package:frontend_mobile_flutter/modules/test/test_controller.dart';
import 'package:get/get.dart';

class TestPage extends GetView<TestController> {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Test Page'),
      ),
    );
  }
}

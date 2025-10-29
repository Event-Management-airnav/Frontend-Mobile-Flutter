import 'package:flutter/material.dart';
import 'package:frontend_mobile_flutter/modules/participant/home/home_controller.dart';
import 'package:get/get.dart';

class ProfilePage extends GetView<HomeController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Participant Profile Page'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:frontend_mobile_flutter/modules/auth/auth_controller.dart';
import 'package:frontend_mobile_flutter/modules/participant/home/home_controller.dart';
import 'package:get/get.dart';

class AuthPage extends GetView<AuthController> {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    _authUser(LoginData data) async {
      Get.snackbar('a', 'a');
    }

    Future<String?> _onLogin(LoginData data) async {
      Get.snackbar('login', 'email: ${data.name}, password: ${data.password}');
      return null;
    }

    Future<String?> _onSignup(SignupData data) async {
      Get.snackbar('signup', 'email: ${data.name}, password: ${data.password}');
      return null;
    }

    Future<String?> _onRecoverPassword(String name) async {
      Get.snackbar('recover password', 'email: $name');
      return null;
    }

    return Scaffold(
      body: FlutterLogin(
        onLogin: _onLogin,
        onSignup: _onSignup,
        onRecoverPassword: _onRecoverPassword,
        additionalSignupFields: [
          UserFormField(
            keyName: 'full_name',
            displayName: 'Full Name',
            fieldValidator: (value) {
              if (value == null || value.isEmpty) {
                return 'Full Name is required';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

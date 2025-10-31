import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:frontend_mobile_flutter/data/models/auth/register_request.dart';
import 'package:frontend_mobile_flutter/modules/auth/auth_controller.dart';
import 'package:frontend_mobile_flutter/modules/auth/otp_verification_page.dart';
import 'package:get/get.dart';
import '../../core/widgets/login_header_widget.dart';
import '../../core/app_colors.dart';
import '../../core/text_styles.dart';

class AuthPage extends GetView<AuthController> {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final headerHeight = screenHeight * 0.10;

    Future<String?> _onLogin(LoginData data) async {
      // Get.snackbar('login', 'email: ${data.name}, password: ${data.password}');
      // return null;
      return controller.login(data.name, data.password);
    }

    Future<String?> _onSignup(SignupData data) async {
      final name = data.additionalSignupData?['name'];
      final telp = data.additionalSignupData?['telp'];
      final username = data.additionalSignupData?['username'];

      if (name == null || telp == null || username == null || data.name == null || data.password == null) {
        return 'Nama lengkap, nomor telepon, dan nama pengguna harus diisi';
      }

      await controller.register(
          name: name,
          username: username,
          email: data.name!,
          telp: telp,
          password: data.password!,
          confirmPassword: data.password!,
          statusKaryawan: 0,
      );

      // Navigate to OTP verification for registration
      Get.to(
        () => OtpVerificationPage(
          email: data.name ?? '',
          isFromRegistration: true,
        ),
        transition: Transition.rightToLeft,
        duration: Duration(milliseconds: 300),
      );

      return null;
    }

    Future<String?> _onRecoverPassword(String email) async {
      // Navigate to OTP verification page
      Get.to(
        () => OtpVerificationPage(email: email),
        transition: Transition.rightToLeft,
        duration: Duration(milliseconds: 300),
      );

      // Return null to prevent flutter_login from showing success message
      // The OTP page will handle the rest of the flow
      return null;
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Container(color: AppColors.background),

          Positioned(
            top: headerHeight,
            left: 0,
            right: 0,
            bottom: 0,
            child: PrimaryScrollController(
              controller: ScrollController(),
              child: Builder(
                builder: (context) {
                  return ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                      scrollbars: false,
                      overscroll: false,
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                    child: Container(
                      color: AppColors.background,
                      child: FlutterLogin(
                        onLogin: _onLogin,
                        onSignup: _onSignup,
                        onRecoverPassword: _onRecoverPassword,

                        additionalSignupFields: [
                          // Field 1: Nama Lengkap
                          UserFormField(
                            keyName: 'name',
                            displayName: 'Nama Lengkap',
                            icon: Icon(Icons.person_outline),
                            fieldValidator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nama lengkap tidak boleh kosong';
                              }
                              if (value.length < 3) {
                                return 'Nama minimal 3 karakter';
                              }
                              return null;
                            },
                          ),

                          // Field 2: Nomor Telepon
                          UserFormField(
                            keyName: 'telp',
                            displayName: 'Nomor Telepon',
                            icon: Icon(Icons.phone_outlined),
                            fieldValidator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nomor telepon tidak boleh kosong';
                              }
                              // Validasi hanya angka
                              if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                return 'Nomor telepon hanya boleh angka';
                              }
                              if (value.length < 10 || value.length > 13) {
                                return 'Nomor telepon 10-13 digit';
                              }
                              return null;
                            },
                          ),

                          // Field 3: Nama User
                          UserFormField(
                            keyName: 'username',
                            displayName: 'Nama Pengguna',
                            icon: Icon(Icons.credit_card),
                            fieldValidator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nama pengguna tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                        ],

                        messages: LoginMessages(
                          userHint: 'Email',
                          passwordHint: 'Enter your password',
                          confirmPasswordHint: 'Konfirmasi password',
                          loginButton: 'Login',
                          signupButton: 'Register',
                          forgotPasswordButton: 'lupa kata sandi',
                          recoverPasswordButton: 'RESET',
                          goBackButton: 'KEMBALI',
                          confirmPasswordError: 'Password tidak cocok!',
                          recoverPasswordDescription:
                              'Masukkan email Anda untuk menerima kode verifikasi',
                          recoverPasswordSuccess:
                              'Kode verifikasi telah dikirim ke email Anda',
                        ),

                        theme: LoginTheme(
                          primaryColor: AppColors.primary,
                          accentColor: AppColors.background,
                          errorColor: AppColors.error,
                          pageColorLight: AppColors.background,
                          pageColorDark: AppColors.background,

                          cardTheme: CardTheme(
                            color: AppColors.background,
                            elevation: 0,
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),

                          inputTheme: InputDecorationTheme(
                            filled: true,
                            fillColor: AppColors.inputFill,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.inputFocus,
                                width: 2,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.error,
                                width: 1,
                              ),
                            ),
                            prefixIconColor: AppColors.textSecondary,
                            suffixIconColor: AppColors.textSecondary,
                          ),

                          buttonTheme: LoginButtonTheme(
                            backgroundColor: AppColors.primary,
                            splashColor: AppColors.primaryDark,
                            highlightColor: AppColors.primaryLight,
                            elevation: 0,
                            highlightElevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),

                          titleStyle: TextStyles.headerMedium.copyWith(
                            color: AppColors.textPrimary,
                          ),
                          bodyStyle: TextStyles.bodyMedium,
                          textFieldStyle: TextStyles.bodyMedium,
                          buttonStyle: TextStyles.button,

                          beforeHeroFontSize: 20,
                          afterHeroFontSize: 20,
                        ),

                        userValidator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukkan email atau username';
                          }
                          return null;
                        },

                        passwordValidator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukkan password';
                          }
                          if (value.length < 8) {
                            return 'Password minimal 8 karakter';
                          }
                          return null;
                        },

                        scrollable: false,
                        hideForgotPasswordButton: false,
                        hideProvidersTitle: true,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Header - Fixed di atas
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: LoginHeaderWidget(
              imagePath: 'assets/images/building_header.png',
              useImageLogo: true,
              logoImagePath: 'assets/images/logo.png',
              logoText: 'AirNav Indonesia',
            ),
          ),
        ],
      ),
    );
  }
}

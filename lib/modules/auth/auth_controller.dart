import 'package:get/get.dart';
import 'package:frontend_mobile_flutter/data/network/services/auth_service.dart';
import 'package:frontend_mobile_flutter/data/models/auth/login_request.dart';
import 'package:frontend_mobile_flutter/data/models/auth/register_request.dart';
import 'package:frontend_mobile_flutter/data/models/auth/forgot_password_request.dart';
import 'package:frontend_mobile_flutter/data/models/auth/otp_verify_request.dart';
import 'package:frontend_mobile_flutter/data/models/auth/otp_resend_request.dart';
import 'package:frontend_mobile_flutter/data/models/auth/reset_password_request.dart';

class AuthController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  
  final RxBool isLoading = false.obs;

  /// Login user
  /// Returns null if success, error message if failed
  Future<String?> login({
    required String emailOrUsername,
    required String password,
  }) async {
    try {
      print('🔵 AuthController: Attempting login...');
      isLoading.value = true;
      
      final request = LoginRequest(
        login: emailOrUsername,
        password: password,
      );
      
      final response = await _authService.login(request);
      
      if (response.success) {
        print('✅ AuthController: Login success');
        return null; // Success
      } else {
        print('❌ AuthController: Login failed - ${response.message}');
        return response.message;
      }
    } catch (e) {
      print('❌ AuthController: Login exception - $e');
      return 'Terjadi kesalahan: $e';
    } finally {
      isLoading.value = false;
    }
  }

  /// Register new user
  /// Returns null if success, error message if failed
  Future<String?> register({
    required String email,
    required String password,
    required String fullName,
    required String phone,
  }) async {
    try {
      print('🔵 AuthController: Attempting register...');
      isLoading.value = true;
      
      final request = RegisterRequest(
        name: fullName,
        username: email.split('@')[0],
        email: email,
        telp: phone,
        password: password,
        passwordConfirmation: password,
        statusKaryawan: 'active', // atau sesuaikan dengan kebutuhan API
      );
      
      final response = await _authService.register(request);
      
      if (response.success) {
        print('✅ AuthController: Register success');
        return null; // Success
      } else {
        print('❌ AuthController: Register failed - ${response.message}');
        if (response.errors != null && response.errors!.isNotEmpty) {
          final firstError = response.errors!.values.first;
          if (firstError is List && firstError.isNotEmpty) {
            return firstError.first.toString();
          }
        }
        return response.message;
      }
    } catch (e) {
      print('❌ AuthController: Register exception - $e');
      return 'Terjadi kesalahan: $e';
    } finally {
      isLoading.value = false;
    }
  }

  /// Send OTP for password reset
  /// Returns null if success, error message if failed
  Future<String?> forgotPassword({required String email}) async {
    try {
      print('🔵 AuthController: Attempting forgot password...');
      isLoading.value = true;
      
      final request = ForgotPasswordRequest(email: email);
      
      final response = await _authService.forgotPassword(request);
      
      if (response.success) {
        print('✅ AuthController: Forgot password success');
        return null; // Success
      } else {
        print('❌ AuthController: Forgot password failed - ${response.message}');
        return response.message;
      }
    } catch (e) {
      print('❌ AuthController: Forgot password exception - $e');
      return 'Terjadi kesalahan: $e';
    } finally {
      isLoading.value = false;
    }
  }

  /// Verify OTP code
  /// Returns null if success, error message if failed
  Future<String?> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      print('🔵 AuthController: Attempting verify OTP...');
      isLoading.value = true;
      
      final request = OtpVerifyRequest(
        email: email,
        otp: otp,
      );
      
      final response = await _authService.verifyOtp(request);
      
      if (response.success) {
        print('✅ AuthController: Verify OTP success');
        return null; // Success
      } else {
        print('❌ AuthController: Verify OTP failed - ${response.message}');
        return response.message;
      }
    } catch (e) {
      print('❌ AuthController: Verify OTP exception - $e');
      return 'Terjadi kesalahan: $e';
    } finally {
      isLoading.value = false;
    }
  }

  /// Resend OTP code
  /// Returns null if success, error message if failed
  Future<String?> resendOtp({required String email}) async {
    try {
      print('🔵 AuthController: Attempting resend OTP...');
      isLoading.value = true;
      
      final request = OtpResendRequest(email: email);
      
      final response = await _authService.resendOtp(request);
      
      if (response.success) {
        print('✅ AuthController: Resend OTP success');
        return null; // Success
      } else {
        print('❌ AuthController: Resend OTP failed - ${response.message}');
        return response.message;
      }
    } catch (e) {
      print('❌ AuthController: Resend OTP exception - $e');
      return 'Terjadi kesalahan: $e';
    } finally {
      isLoading.value = false;
    }
  }

  /// Reset password with OTP
  /// Returns null if success, error message if failed
  Future<String?> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    try {
      print('🔵 AuthController: Attempting reset password...');
      isLoading.value = true;
      
      final request = ResetPasswordRequest(
        email: email,
        token: otp,
        password: newPassword,
        passwordConfirmation: newPassword,
      );
      
      final response = await _authService.resetPassword(request);
      
      if (response.success) {
        print('✅ AuthController: Reset password success');
        return null; // Success
      } else {
        print('❌ AuthController: Reset password failed - ${response.message}');
        return response.message;
      }
    } catch (e) {
      print('❌ AuthController: Reset password exception - $e');
      return 'Terjadi kesalahan: $e';
    } finally {
      isLoading.value = false;
    }
  }

  /// Logout user
  Future<void> logout() async {
    try {
      print('🔵 AuthController: Attempting logout...');
      isLoading.value = true;
      
      await _authService.secure.delete(key: "access_token");
      _authService.storage.remove("name");
      _authService.storage.remove("username");
      _authService.storage.remove("role");
      _authService.storage.remove("email");
      
      print('✅ AuthController: Logout success');
      Get.offAllNamed('/login');
      
    } catch (e) {
      print('❌ AuthController: Logout exception - $e');
      Get.snackbar(
        'Error',
        'Gagal logout: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Check if user is logged in
  Future<bool> isLoggedIn() async {
    try {
      final token = await _authService.secure.read(key: "access_token");
      final isLogged = token != null && token.isNotEmpty;
      print('🔵 AuthController: Is logged in? $isLogged');
      return isLogged;
    } catch (e) {
      print('❌ AuthController: Check login exception - $e');
      return false;
    }
  }

  /// Get stored user data
  Map<String, dynamic> getUserData() {
    final userData = {
      'name': _authService.storage.read("name"),
      'username': _authService.storage.read("username"),
      'role': _authService.storage.read("role"),
      'email': _authService.storage.read("email"),
    };
    print('🔵 AuthController: User data - $userData');
    return userData;
  }

  @override
  void onInit() {
    super.onInit();
    print('🔵 AuthController: Initialized');
  }

  @override
  void onClose() {
    print('🔵 AuthController: Closed');
    super.onClose();
  }
}
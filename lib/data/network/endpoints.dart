import 'package:frontend_mobile_flutter/env/env.dart';

class Endpoints {
  static final String baseUrl = Env.baseUrl;


  // Auth
  static final register = "$baseUrl/register";
  static final login = "$baseUrl/login";
  static final logout = "$baseUrl/logout";

  // OTP
  static final verifyOtp = "$baseUrl/verify-otp";
  static final resendOtp = "$baseUrl/resend-otp";

  // Password
  static final forgotPassword = "$baseUrl/forgot-password";
  static final resetPassword = "$baseUrl/reset-password";

  // Profile
  static final profile = "$baseUrl/profile";
  static final profileUpdate = "$baseUrl/profile/update";
  static final profileChangePassword = "$baseUrl/profile/change-password";
}

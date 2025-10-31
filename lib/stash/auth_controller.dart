// import 'package:frontend_mobile_flutter/data/models/auth/otp_verify_request.dart';
// import 'package:get/get.dart';
//
// import '../../data/models/login_request.dart';
// import '../../data/models/register_request.dart';
// import '../../data/models/otp_request.dart';
// import '../../data/models/forgot_password_request.dart';
//
// import '../../data/network/services/auth_service.dart';
// import '../data/models/auth/login_request.dart';
// import '../data/models/auth/register_request.dart';
//
// enum AuthStep {
//   login,
//   register,
//   otp,
//   forgotPassword,
// }
//
// class AuthController extends GetxController {
//   final authService = Get.find<AuthService>();
//
//   // UI step/state
//   final currentStep = AuthStep.login.obs;
//
//   // General loading state
//   final isLoading = false.obs;
//
//   // Feedback message
//   final message = "".obs;
//
//   // Hold the last used email for OTP resend flow
//   String? lastEmail;
//
//   // Change page step
//   void goTo(AuthStep step) {
//     currentStep.value = step;
//   }
//
//   // LOGIN
//   Future<void> login(LoginRequest req) async {
//     try {
//       isLoading.value = true;
//
//       final res = await authService.login(req);
//       message.value = res.message;
//
//       if (res.success) {
//         // Navigate to participant/admin home based on role (optional)
//         if (res.data!.user.role == "admin") {
//           Get.offAllNamed("/admin/dashboard");
//         } else {
//           Get.offAllNamed("/participant/home");
//         }
//
//         lastEmail = res.data!.user.email;
//       }
//
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   // REGISTER
//   Future<void> register(RegisterRequest req) async {
//     try {
//       isLoading.value = true;
//
//       final res = await authService.register(req);
//       message.value = res.message;
//
//       if (res.success) {
//         lastEmail = req.email;
//         currentStep.value = AuthStep.otp;
//       }
//
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   // VERIFY OTP
//   Future<void> verifyOtp(OtpVerifyRequest req) async {
//     try {
//       isLoading.value = true;
//
//       final res = await authService.verifyOtp(req);
//       message.value = res.message;
//
//       if (res.success) {
//         currentStep.value = AuthStep.login;
//       }
//
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   // RESEND OTP
//   Future<void> resendOtp() async {
//     if (lastEmail == null) return;
//
//     try {
//       isLoading.value = true;
//
//       final res = await authService.resendOtp(lastEmail!);
//       message.value = res.message;
//
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> forgotPassword(ForgotPasswordRequest req) async {
//     try {
//       isLoading.value = true;
//
//       final res = await authService.forgotPassword(req);
//       message.value = res.message;
//
//       if (res.success) {
//         currentStep.value = AuthStep.otp;
//         lastEmail = req.email;
//       }
//
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   // LOGOUT
//   Future<void> logout() async {
//     try {
//       isLoading.value = true;
//
//       await authService.logout();
//       Get.offAllNamed("/auth");
//       currentStep.value = AuthStep.login;
//
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

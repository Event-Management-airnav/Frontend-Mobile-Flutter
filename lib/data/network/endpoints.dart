class Endpoints {
  // Auth
  static const register = "/api/register";
  static const login = "/api/login";
  static const logout = "/api/logout";

  // OTP
  static const verifyOtp = "/api/verify-otp";
  static const resendOtp = "/api/resend-otp";

  // Password
  static const forgotPassword = "/api/forgot-password";
  static const resetPassword = "/api/reset-password";

  // Profile
  static const profile = "/api/profile";
  static const profileUpdate = "/api/profile/update";
  static const profileChangePassword = "/api/profile/change-password";

  // Home
  static const eventsAll = "/api/events/all";
  static const events = "/api/events";
  static const eventsUpcoming = "/api/events/upcoming";
  static const eventsPast = "/api/events/past";

  // Event Detail
  static const eventDetail = "/api/events";

  // Pendaftaran
  static const mePendaftaran = "/api/me/pendaftaran";
}

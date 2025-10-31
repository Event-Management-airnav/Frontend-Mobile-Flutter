import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/app_colors.dart';
import '../../core/text_styles.dart';
import '../../core/widgets/otp_widgets.dart';
import 'reset_password_page.dart';

class OtpVerificationPage extends StatefulWidget {
  final String email;
  
  const OtpVerificationPage({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  String otpCode = '';
  bool isLoading = false;

  void _onNumberTap(String value) {
    if (otpCode.length < 6) {
      setState(() {
        otpCode = otpCode + value;
      });
      
      // Auto submit when 6 digits are entered
      if (otpCode.length == 6) {
        _autoVerifyOtp();
      }
    }
  }

  void _onBackspace() {
    if (otpCode.isNotEmpty) {
      setState(() {
        otpCode = otpCode.substring(0, otpCode.length - 1);
      });
    }
  }

  Future<void> _autoVerifyOtp() async {
    setState(() {
      isLoading = true;
    });

    try {
      // TODO: Replace with your actual API call
      // Example:
      // final response = await controller.verifyOtp(
      //   email: widget.email,
      //   code: otpCode,
      // );
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 1));

      // Navigate to Reset Password Page
      Get.off(
        () => ResetPasswordPage(email: widget.email),
        transition: Transition.rightToLeft,
        duration: Duration(milliseconds: 300),
      );
      
    } catch (e) {
      setState(() {
        isLoading = false;
        otpCode = ''; // Clear OTP on error
      });
      
      Get.snackbar(
        'Error',
        'Kode OTP tidak valid',
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final boxSize = screenWidth * 0.13;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primary.withOpacity(0.1),
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 40),
                        
                        // Title
                        Text(
                          'Verifikasi Kode',
                          style: TextStyles.headerLarge.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 30),
                        
                        // Subtitle
                        Text(
                          'Konfirmasi OTP',
                          style: TextStyles.headerMedium.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 12),
                        
                        // Description
                        Text(
                          'Kami telah mengirim kode ke email\nAnda. Silakan masukkan di sini',
                          textAlign: TextAlign.center,
                          style: TextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 50),
                        
                        // OTP Boxes
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            6,
                            (index) => Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6),
                              child: OtpWidgets.buildOtpBox(
                                position: index,
                                otpCode: otpCode,
                                boxSize: boxSize,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 60),
                      ],
                    ),
                  ),
                ),
                
                // Numeric Keyboard
                OtpWidgets.buildNumericKeyboard(
                  onNumberTap: _onNumberTap,
                  onBackspace: _onBackspace,
                  buttonSize: 70,
                  spacing: 15,
                ),
                
                SizedBox(height: 20),
              ],
            ),
          ),
          
          // Loading Overlay
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
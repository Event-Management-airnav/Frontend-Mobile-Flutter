import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../text_styles.dart';

class OtpWidgets {
  // OTP Box Widget
  static Widget buildOtpBox({
    required int position,
    required String otpCode,
    required double boxSize,
  }) {
    bool hasDigit = position < otpCode.length;
    
    return Container(
      height: boxSize,
      width: boxSize,
      decoration: BoxDecoration(
        color: hasDigit ? AppColors.inputFocus.withOpacity(0.1) : Colors.white,
        border: Border.all(
          color: hasDigit ? AppColors.primary : Colors.grey.shade300,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          hasDigit ? otpCode[position] : '',
          style: TextStyles.headerMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: boxSize * 0.5,
          ),
        ),
      ),
    );
  }

  // Number Button Widget
  static Widget buildNumberButton({
    required String number,
    required VoidCallback onTap,
    required double buttonSize,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        height: buttonSize,
        width: buttonSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
        child: Center(
          child: Text(
            number,
            style: TextStyle(
              fontSize: buttonSize * 0.4,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }

  // Backspace Button Widget
  static Widget buildBackspaceButton({
    required VoidCallback onTap,
    required double buttonSize,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        height: buttonSize,
        width: buttonSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
        child: Center(
          child: Icon(
            Icons.backspace_outlined,
            color: AppColors.textSecondary,
            size: buttonSize * 0.4,
          ),
        ),
      ),
    );
  }

  // Numeric Keyboard Widget
  static Widget buildNumericKeyboard({
    required Function(String) onNumberTap,
    required VoidCallback onBackspace,
    double buttonSize = 70.0,
    double spacing = 15.0,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          // Row 1-3
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildNumberButton(
                number: '1',
                onTap: () => onNumberTap('1'),
                buttonSize: buttonSize,
              ),
              buildNumberButton(
                number: '2',
                onTap: () => onNumberTap('2'),
                buttonSize: buttonSize,
              ),
              buildNumberButton(
                number: '3',
                onTap: () => onNumberTap('3'),
                buttonSize: buttonSize,
              ),
            ],
          ),
          SizedBox(height: spacing),
          // Row 4-6
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildNumberButton(
                number: '4',
                onTap: () => onNumberTap('4'),
                buttonSize: buttonSize,
              ),
              buildNumberButton(
                number: '5',
                onTap: () => onNumberTap('5'),
                buttonSize: buttonSize,
              ),
              buildNumberButton(
                number: '6',
                onTap: () => onNumberTap('6'),
                buttonSize: buttonSize,
              ),
            ],
          ),
          SizedBox(height: spacing),
          // Row 7-9
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildNumberButton(
                number: '7',
                onTap: () => onNumberTap('7'),
                buttonSize: buttonSize,
              ),
              buildNumberButton(
                number: '8',
                onTap: () => onNumberTap('8'),
                buttonSize: buttonSize,
              ),
              buildNumberButton(
                number: '9',
                onTap: () => onNumberTap('9'),
                buttonSize: buttonSize,
              ),
            ],
          ),
          SizedBox(height: spacing),
          // Row 0 and backspace
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: buttonSize),
              buildNumberButton(
                number: '0',
                onTap: () => onNumberTap('0'),
                buttonSize: buttonSize,
              ),
              buildBackspaceButton(
                onTap: onBackspace,
                buttonSize: buttonSize,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
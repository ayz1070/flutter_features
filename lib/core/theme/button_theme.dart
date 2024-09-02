import 'package:flutter/material.dart';

import 'colors.dart';

class AppButtonTheme {
  static final ButtonStyle mainButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: AppColors.primaryColor,
    backgroundColor: AppColors.buttonBackgroundColor,
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    textStyle: const TextStyle(fontSize: 14, color: Colors.white),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0), // 네모난 모양으로 설정
    ),
  );
}
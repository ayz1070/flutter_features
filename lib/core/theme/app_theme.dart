import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.backgroundPrimaryColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundPrimaryColor,
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
      iconTheme: IconThemeData(color: Colors.black),
    ),
    // 기타 라이트 테마 설정
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.backgroundPrimaryColorDark,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundPrimaryColorDark,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      iconTheme: IconThemeData(color: Colors.white),

    ),
    // 기타 다크 테마 설정
  );
}
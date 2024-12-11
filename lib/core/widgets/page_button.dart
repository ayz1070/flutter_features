import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/text_styles.dart';

class PageButton extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry paddingHorizontal;
  final VoidCallback? onPressed;

  const PageButton({
    super.key,
    required this.text, // 버튼 텍스트
    required this.paddingHorizontal, // padding 설정
    required this.onPressed // 버튼 클릭 시 실행할 함수
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingHorizontal,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 17.0),
          minimumSize: const Size(double.infinity, 52),
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        child: Text(
            text,
            style: AppTextStyles.medium15.copyWith(color: Colors.white)
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';

class CartBuyButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const CartBuyButton(
      {super.key,
        required this.title, // 버튼 텍스트
        required this.onPressed // 버튼 클릭 시 실행할 함수
      });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(0, 30),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
      ),
      child: Text(
        title,
        style: AppTextStyles.regular11
      ),
    );
  }
}


import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/formatter.dart';

class CartPageButton extends StatelessWidget {
  final double totalPrice;
  final double finalPrice;
  final EdgeInsetsGeometry paddingHorizontal;
  final VoidCallback? onPressed;

  const CartPageButton({
    super.key,
    required this.totalPrice, // 버튼 텍스트
    required this.finalPrice, // 버튼 텍스트
    required this.paddingHorizontal, // padding 설정
    required this.onPressed, // 버튼 클릭 시 실행할 함수
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
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${Formatter.formatPrice(totalPrice)}",
              style: AppTextStyles.medium15.copyWith(
                decoration: TextDecoration.lineThrough,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "${Formatter.formatPrice(finalPrice)}",
              style: AppTextStyles.medium15
            ),
            Text(
              " 주문하기",
              style: AppTextStyles.medium15
            ),
          ],
        ),
      ),
    );
  }
}

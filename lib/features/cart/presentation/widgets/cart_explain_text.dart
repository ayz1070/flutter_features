import 'package:flutter/material.dart';

import '../../../../core/theme/text_styles.dart';

class CartExplainText extends StatelessWidget {
  const CartExplainText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        children: [
          Text(
            "· 장바구니에 최대 100개의 상품을 담을 수 있습니다.",
            style: AppTextStyles.regular12.copyWith(
            ),
          ),
          Text(
            "· 장바구니에 담긴 상품은 30일간 보관후 삭제됩니다.",
            style: AppTextStyles.regular12.copyWith(
            ),
          ),
        ],
      ),
    );
  }
}

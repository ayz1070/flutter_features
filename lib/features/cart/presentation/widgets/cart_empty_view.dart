import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';

class CartEmptyView extends StatelessWidget {
  const CartEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 45,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), // 둥근 모서리
            ),
            width: double.infinity,
            height: 180,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('장바구니에 담긴 상품이 없습니다.', style: AppTextStyles.medium16),
                SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () {
                    // 쇼핑하러 가기 버튼 동작 처리
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    side: BorderSide(
                    ),
                  ),
                  child: Text(
                    '쇼핑하러 가기',
                    style: AppTextStyles.medium14
                  ),
                ),              ],
            ),
          ),
        ],
      ),
    );
  }
}

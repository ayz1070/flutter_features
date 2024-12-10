import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/formatter.dart';

class CartSummaryView extends StatelessWidget {
  final int quantity;
  final double totalPrice;
  final double discount;
  final double deliveryFee;
  final double finalPrice;
  final double rewardPoints;
  final VoidCallback onPressed;

  const CartSummaryView({
    Key? key,
    required this.quantity,
    required this.totalPrice,
    required this.discount,
    required this.deliveryFee,
    required this.finalPrice,
    required this.rewardPoints,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundPrimaryColor,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '주문 상품 수',
                  style: AppTextStyles.regular13.copyWith(
                    color: AppColors.textSecondaryColor,
                  ),
                ),
                Text(
                  "총 ${quantity}개",
                  style: AppTextStyles.semiBold13
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '총 주문금액',
                  style: AppTextStyles.regular13.copyWith(
                    color: AppColors.textSecondaryColor,
                  ),
                ),
                Text(
                    "${Formatter.formatPrice(totalPrice)}",
                    style: AppTextStyles.semiBold13
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '총 배송비',
                  style: AppTextStyles.regular13.copyWith(
                    color: AppColors.textSecondaryColor,
                  ),
                ),
                Text(
                    "${Formatter.formatPrice(deliveryFee)}",
                    style: AppTextStyles.semiBold13
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '총 할인 금액',
                  style: AppTextStyles.regular13.copyWith(
                    color: AppColors.textSecondaryColor,
                  ),
                ),
                Text(
                    "-${Formatter.formatPrice(discount)}",
                    style: AppTextStyles.semiBold13.copyWith(
                      color: Color(0xFFFF4F4D),
                    )
                ),
              ],
            ),

            SizedBox(height: 12),
            Divider(
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '총 결제 금액',
                  style: AppTextStyles.regular16.copyWith(
                    color: AppColors.textSecondaryColor,
                  ),
                ),
                Text(
                  "${Formatter.formatPrice(finalPrice)}",
                  style: AppTextStyles.semiBold16,
                ),
              ],
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '구매 시 +${Formatter.formatPrice(rewardPoints)} 적립 (포인트 적립 적용 구현 필요)',
                style: AppTextStyles.regular11.copyWith(
                  color: Color(0xFF322BFE),
                ),
              ),
            ),
            SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}
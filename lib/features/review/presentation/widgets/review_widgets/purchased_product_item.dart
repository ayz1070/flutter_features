import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/widgets/expanded_button.dart';
import '../../vm/product_view_model.dart';

class PurchasedProductItem extends StatelessWidget {
  final ProductViewModel productViewModel;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final VoidCallback? onAddPressed;

  const PurchasedProductItem({
    Key? key,
    required this.productViewModel,
    this.titleStyle,
    this.subtitleStyle,
    this.onAddPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '구매 날짜: ${DateFormat('yyyy년 MM월 dd일').format(productViewModel.purchaseDate)}',
            style: titleStyle ?? AppTextStyles.regular14,
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  productViewModel.productImageUrl,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error, color: Colors.grey);
                  },
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productViewModel.productName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      '리뷰 작성 가능', // localization 적용 가능
                      style: subtitleStyle ?? AppTextStyles.medium12,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              ExpandedButton(
                title: "리뷰 남기기",
                onPressed: () async {
                  // 페이지 이동 후 돌아왔을 때 새로고침 여부 확인
                  final result = await context.push(
                    '/my/review/add/${productViewModel.productId}',
                    extra: productViewModel,
                  );
                  // result가 true일 경우 새로고침 트리거
                  if (result == true) {
                    onAddPressed?.call(); // 부모 위젯에서 새로고침 로직을 수행
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

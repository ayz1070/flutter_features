import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../vm/cart_product_view_model.dart';

class ProductPriceRow extends StatelessWidget {
  final CartProductViewModel item;

  const ProductPriceRow({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 원래 가격 (취소선)
        if (item.discountPrice != item.price)
          Text(
            '${item.price}원',
            style: AppTextStyles.regular12.copyWith(
              decoration: TextDecoration.lineThrough,
            ),
          ),
        SizedBox(width: 5),
        // 할인된 가격
        Text(
          '${item.discountPrice}원',
          style: AppTextStyles.medium14.copyWith(),
        ),
      ],
    );
  }
}

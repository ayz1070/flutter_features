// ProductInfo Widget
import 'package:flutter/material.dart';

import '../../../../../core/theme/text_styles.dart';
import '../../vm/product_view_model.dart';

class ReviewAddProductInfo extends StatelessWidget {
  final ProductViewModel productViewModel;

  const ReviewAddProductInfo({required this.productViewModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            productViewModel.productImageUrl,
            width: 70,
            height: 70,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Icon(Icons.error, color: Colors.grey),
          ),
        ),
        SizedBox(width: 16),
        Text(productViewModel.productName, style: AppTextStyles.semiBold16),
      ],
    );
  }
}
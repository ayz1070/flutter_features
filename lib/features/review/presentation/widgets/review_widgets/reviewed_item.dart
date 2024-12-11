import 'package:flutter/material.dart';
import 'package:flutter_features/features/review/presentation/widgets/review_widgets/reviewed_stars.dart';
import 'package:intl/intl.dart';

import '../../../../../core/widgets/expanded_button.dart';
import '../../../domain/entities/review.dart';
import '../../vm/product_view_model.dart';

class ReviewedItem extends StatelessWidget {
  final Review review;
  final ProductViewModel productInfo;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ReviewedItem({
    Key? key,
    required this.review,
    required this.productInfo,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('배송 완료일: ${DateFormat('yyyy년 MM월 dd일').format(productInfo.purchaseDate)}'),
              SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      productInfo.productImageUrl,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(Icons.error, color: Colors.grey),
                    ),
                  ),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(productInfo.productName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        SizedBox(height: 8),
                        ReviewedStars(rating: review.rating),
                        SizedBox(height: 16),
                        Text(review.content ?? '리뷰 내용이 없습니다.'),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  ExpandedButton(
                    title: "수정하기",
                    onPressed: onEdit,
                  ),
                  SizedBox(width: 8),
                  ExpandedButton(
                    title: "삭제하기",
                    onPressed: onDelete,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
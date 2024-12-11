// StarRatingInput Widget
import 'package:flutter/material.dart';
import 'package:flutter_features/features/review/presentation/widgets/review_add_widgets/review_stars.dart';

import '../../../../../core/theme/text_styles.dart';

class StarRatingInput extends StatelessWidget {
  final double initialRating;
  final ValueChanged<double> onRatingChanged;

  const StarRatingInput({required this.initialRating, required this.onRatingChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('이 상품의 품질에 대해 얼마나 만족하시나요?', style: AppTextStyles.semiBold16),
        SizedBox(height: 16),
        ReviewStars(initialRating: initialRating, onRatingChanged: onRatingChanged),
      ],
    );
  }
}
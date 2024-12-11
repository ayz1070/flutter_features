
// ReviewTextInput Widget
import 'package:flutter/material.dart';
import 'package:flutter_features/features/review/presentation/widgets/review_add_widgets/review_text_field.dart';

import '../../../../../core/theme/text_styles.dart';

class ReviewAddTextInput extends StatelessWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;

  const ReviewAddTextInput({required this.initialValue, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('이 상품을 상세히 평가해주세요.', style: AppTextStyles.semiBold16),
        SizedBox(height: 16),
        ReviewTextField(initialValue: initialValue, onChanged: onChanged),
      ],
    );
  }
}
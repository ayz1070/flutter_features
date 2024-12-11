// SubmitButton Widget
import 'package:flutter/material.dart';

import '../../../../../core/widgets/page_button.dart';


class ReviewSubmitButton extends StatelessWidget {
  final bool isEditing;
  final VoidCallback onPressed;

  const ReviewSubmitButton({required this.isEditing, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: PageButton(
        text: isEditing ? "리뷰 수정 완료" : "리뷰 작성 완료",
        paddingHorizontal: EdgeInsets.zero,
        onPressed: onPressed,
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';

class PointToReviewBar extends StatelessWidget {
  const PointToReviewBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF333333),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "추가 마일리지 받기",
              style: AppTextStyles.regular14.copyWith(color: Colors.white),
            ),
            TextButton(
              onPressed: () {
                context.push('/my/review');
              },
              child: Row(
                children: [
                  Text(
                    "리뷰 쓰기",
                    style: AppTextStyles.regular14
                        .copyWith(color: AppColors.primaryColor),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.primaryColor,
                    size: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

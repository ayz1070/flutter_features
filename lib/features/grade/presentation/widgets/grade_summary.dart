import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';

class GradeSummary extends StatelessWidget {
  const GradeSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundPrimaryColor,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "다음 달 예상 등급",
              style: AppTextStyles.semiBold20,
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "예상 등급 산정기간",
                  style: AppTextStyles.light14.copyWith(
                    color: AppColors.textSecondaryColor,
                  ),
                ),
                Text(
                  "2024년 5월~ 현재",
                  style: AppTextStyles.light14.copyWith(
                    color: AppColors.textPrimaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "누적 구매 확정금액",
                  style: AppTextStyles.light14.copyWith(
                    color: AppColors.textSecondaryColor,
                  ),
                ),
                Text(
                  "123,000원",
                  style: AppTextStyles.light14.copyWith(
                    color: AppColors.textPrimaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "이번 달 구매 횟수",
                  style: AppTextStyles.light14.copyWith(
                    color: AppColors.textSecondaryColor,
                  ),
                ),
                Text(
                  "10번",
                  style: AppTextStyles.light14.copyWith(
                    color: AppColors.textPrimaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "다음 달 예산등급",
                  style: AppTextStyles.light14.copyWith(
                    color: AppColors.textSecondaryColor,
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      "lib/core/assets/icons/icon_grade_welcome.svg",
                      height: 20,
                      width: 20,
                    ),
                    SizedBox(width: 4,),
                    Text(
                      "플래티넘",
                      style: AppTextStyles.light14.copyWith(
                        color: AppColors.textPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

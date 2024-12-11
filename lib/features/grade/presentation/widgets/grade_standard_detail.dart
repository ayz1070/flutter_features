import 'package:flutter/material.dart';

import '../../../../core/theme/text_styles.dart';

class GradeStandardDetail extends StatelessWidget {
  const GradeStandardDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 베이직 등급
          Text(
            '베이직',
            style: AppTextStyles.bold16
          ),
          SizedBox(height: 8),
          Text(
            '1. 가입 시 자동',
            style: AppTextStyles.regular12,
          ),
          SizedBox(height: 24),

          // 실버 등급
          Text(
            '실버',
              style: AppTextStyles.bold16
          ),
          SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '1. 최근 6개월 동안 누적 구매 금액 ',
                  style:  AppTextStyles.regular12,
                ),
                TextSpan(
                  text: '50만 원',
                  style: AppTextStyles.regular12,
                ),
                TextSpan(
                  text: ' 이상',
                  style: AppTextStyles.regular12,
                ),
              ],
            ),
          ),
          SizedBox(height: 4),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '2. 또는 최근 6개월 동안 ',
                  style: AppTextStyles.regular12,
                ),
                TextSpan(
                  text: '10회 이상 구매',
                  style: AppTextStyles.regular12,
                ),
              ],
            ),
          ),
          SizedBox(height: 24),

          // 골드 등급
          Text(
            '골드',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '1. 최근 6개월 동안 누적 구매 금액 ',
                  style: AppTextStyles.regular12,
                ),
                TextSpan(
                  text: '300만 원',
                  style: AppTextStyles.regular12,
                ),
                TextSpan(
                  text: ' 이상',
                  style: AppTextStyles.regular12,
                ),
              ],
            ),
          ),
          SizedBox(height: 4),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '2. 또는 최근 6개월 동안 ',
                  style: AppTextStyles.regular12,
                ),
                TextSpan(
                  text: '20회 이상 구매',
                  style: AppTextStyles.regular12,
                ),
              ],
            ),
          ),
          SizedBox(height: 24),

          // 플래티넘 등급
          Text(
            '플래티넘',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '1. 최근 6개월 동안 누적 구매 금액 ',
                  style: AppTextStyles.regular12,
                ),
                TextSpan(
                  text: '500만 원',
                  style: AppTextStyles.regular12,
                ),
                TextSpan(
                  text: ' 이상',
                  style: AppTextStyles.regular12,
                ),
              ],
            ),
          ),
          SizedBox(height: 4),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '2. 또는 최근 6개월 동안 ',
                  style: AppTextStyles.regular12,
                ),
                TextSpan(
                  text: '40회 이상 구매',
                  style: AppTextStyles.regular12,
                ),
              ],
            ),
          ),
          SizedBox(height: 24),

          // 다이아몬드 등급
          Text(
            '다이아몬드',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '1. 최근 6개월 동안 누적 구매 금액 ',
                  style: AppTextStyles.regular12,
                ),
                TextSpan(
                  text: '1,000만 원',
                  style: AppTextStyles.regular12,
                ),
                TextSpan(
                  text: ' 이상',
                  style: AppTextStyles.regular12,
                ),
              ],
            ),
          ),
          SizedBox(height: 4),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '2. 또는 최근 6개월 동안 ',
                  style: AppTextStyles.regular12,
                ),
                TextSpan(
                  text: '60회 이상 구매',
                  style: AppTextStyles.regular12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
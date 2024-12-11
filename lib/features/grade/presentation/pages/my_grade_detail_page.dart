import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_screen_size.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../domain/entities/grade.dart';

class MyGradeDetailPage extends StatelessWidget {
  final Grade grade;

  MyGradeDetailPage({required this.grade});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSecondaryColor,
      appBar: AppBar(
        title: Text(
          '등급',
          style: AppTextStyles.semiBold18,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        backgroundColor: AppColors.backgroundPrimaryColor,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: AppScreenSize.webMaxSize,
          ),
          child: Container(
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.backgroundPrimaryColor),
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        child: Image.asset(
                          'lib/core/assets/icons/icon_grade_${grade.name}.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        grade.getTranslatedName(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Divider(
                        color: AppColors.dividerPrimaryColor,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Points rate
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '포인트 적립률',
                        style: AppTextStyles.bold16,
                      ),
                      Text(
                        '${grade.pointRate}%',
                        style: AppTextStyles.bold16
                            .copyWith(color: AppColors.primaryColor),
                      ),
                    ],
                  ),

                  SizedBox(height: 48),
                  // Benefits
                  Text(
                    '혜택',
                    style: AppTextStyles.bold16,
                  ),
                  SizedBox(height: 16),
                  ...grade.benefits.map((benefit) => Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                          benefit,
                          style: AppTextStyles.regular12,
                        ),
                      )),
                  SizedBox(height: 48),
                  // Upgrade conditions
                  Text(
                    '등급 상향 조건',
                    style: AppTextStyles.bold16,
                  ),
                  SizedBox(height: 16),
                  RichText(
                    text: TextSpan(
                      text: '1. 최근 6개월 동안 누적 구매 금액 ',
                      style: AppTextStyles.regular12,
                      children: [
                        TextSpan(
                          text: '${grade.upgradeAmount ~/ 10000}만 원 ',
                          style: AppTextStyles.semiBold12.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        TextSpan(
                          text: '이상',
                          style: AppTextStyles.regular12,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      text: '2. 또는 최근 6개월 동안 ',
                      style: AppTextStyles.regular12,
                      children: [
                        TextSpan(
                          text: '${grade.upgradePurchaseCount}회 ',
                          style: AppTextStyles.semiBold12.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        TextSpan(
                          text: '이상 구매',
                          style: AppTextStyles.regular12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

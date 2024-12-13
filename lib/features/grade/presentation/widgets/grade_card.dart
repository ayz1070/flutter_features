import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';

class GradeCard extends StatelessWidget {
  final String gradeName;

  const GradeCard({super.key, required this.gradeName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: SvgPicture.asset(
            "lib/core/assets/images/grade_bar_${gradeName}.svg",
            fit: BoxFit.cover,
          ),
        ),
        Container(
          color: AppColors.backgroundPrimaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 24,
              ),
              Container(
                color: AppColors.primaryColor,
                width: 107,
                height: 8,
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "${gradeName}",
                          style: AppTextStyles.semiBold18,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "등급 할인 혜택",
                          style: AppTextStyles.semiBold16,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "첫구매 3,000원 쿠폰+생일 3,000원 쿠폰",
                          style: AppTextStyles.regular14,
                        ),
                        Text(
                          "포인트 적립률 1%",
                          style: AppTextStyles.regular14,
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Text(
                          "등급 산정 기준",
                          style: AppTextStyles.semiBold16,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text("가입시 자동 적용"),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

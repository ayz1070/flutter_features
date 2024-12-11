import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../domain/entities/grade.dart';
import '../../domain/entities/user_grade.dart';

class MyGradeProfile extends StatelessWidget {
  final UserGrade userGrade;
  final Grade grade;

  const MyGradeProfile({Key? key, required this.userGrade, required this.grade})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 32, 20, 16),
      child: Container(
        width: double.infinity,
        color: AppColors.backgroundPrimaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            SvgPicture.asset(
              'lib/core/assets/icons/icon_grade_welcome.svg',
              height: 50.0, // 원하는 크기로 설정
              width: 50.0,
            ),
            SizedBox(width: 16),
            Text(
              "${userGrade.name}님은 \n골드 등급입니다.",
              style: AppTextStyles.semiBold20,
              textAlign: TextAlign.center,
            ),
            SizedBox(width: 4),
            Text("포인트 2% 적립+상시 추가 할인 3%"),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

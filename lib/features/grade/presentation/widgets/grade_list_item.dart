import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../domain/entities/grade.dart';
import '../pages/my_grade_detail_page.dart';

class GradeListItem extends StatelessWidget {
  final Grade grade; // Grade 엔티티를 직접 받음

  const GradeListItem({Key? key, required this.grade}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 15, 12),
      decoration: BoxDecoration(
        color: AppColors.backgroundPrimaryColor,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: AppColors.borderPrimaryColor),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        leading: Container(
          width: 50,
          height: 50,
          child: Image.asset(
            'assets/icons/icon_grade_${grade.name}.png',
            width: 40,
            height: 40,
          ),
        ),
        title: Text(
          grade.getTranslatedName(),
          style: AppTextStyles.medium12,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(
              '포인트 적립 ${grade.pointRate}%',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4),
            Text(
              '상시 추가 할인 ${grade.discountRate * 100}%',
              style: AppTextStyles.semiBold14.copyWith(color: Colors.red),
            ),
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,

          size: 18,
        ),
        onTap: () {
        },
      ),
    );
  }
}

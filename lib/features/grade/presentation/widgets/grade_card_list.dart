import 'package:flutter/material.dart';

import '../../../../core/theme/text_styles.dart';
import 'grade_card.dart';

class GradeCardList extends StatelessWidget {
  const GradeCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "등급별 혜택",
            style: AppTextStyles.semiBold20,
          ),
          SizedBox(height: 16,),
          GradeCard(gradeName: "welcome"),
          SizedBox(height: 16,),
          GradeCard(gradeName: "silver"),
          SizedBox(height: 16,),
          GradeCard(gradeName: "gold"),
          SizedBox(height: 16,),
          GradeCard(gradeName: "platinum"),
          SizedBox(height: 16,),
          GradeCard(gradeName: "vip"),
        ],
      ),
    );
  }
}

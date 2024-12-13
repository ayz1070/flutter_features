import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';


class MyGradeTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundPrimaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),

      child: TabBar(
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        indicatorColor: AppColors.primaryColor,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 4, color: AppColors.primaryColor),
          insets: EdgeInsets.symmetric(horizontal: 100),
        ),
        tabs: [
          Tab(text: '등급별 혜택 안내'),
          Tab(text: '등급 산정 기준'),
        ],
      ),
    );
  }
}
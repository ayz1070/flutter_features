import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';

class PointTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // 탭바에만 padding을 적용
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          TabBar(
            dividerColor: Colors.transparent,
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            labelStyle: AppTextStyles.medium15,
            unselectedLabelColor: AppColors.textHintPrimaryColor,
            unselectedLabelStyle: AppTextStyles.medium15.copyWith(color: AppColors.primaryColor),
            isScrollable: false,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(text: '전체'),
              Tab(text: '적립'),
              Tab(text: '차감'),
            ],
          ),

        ],
      ),
    );
  }
}
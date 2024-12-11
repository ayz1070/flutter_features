import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/formatter.dart';
import '../../../../core/utils/test_data.dart';
import '../vm/point_summary_view_model.dart';

class PointSummary extends StatelessWidget {
  final PointSummaryViewModel pointSummaryViewModel;

  const PointSummary({super.key, required this.pointSummaryViewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundTertiaryColor,
      padding: EdgeInsets.fromLTRB(20, 30, 20, 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            'lib/core/assets/icons/icon_point.svg',
            width: 22,
            height: 22,
          ),
          SizedBox(height: 6,),
          Text(
            '${TestData.loginedUser.name} 님의\n사용가능 포인트',
            style: AppTextStyles.regular18.copyWith(color: Colors.white),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                Formatter.formatPoint(pointSummaryViewModel.totalPoint),
                style: AppTextStyles.light32.copyWith(color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

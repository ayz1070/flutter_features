import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';

class PointEmptyListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 120,),
        // 아이콘 혹은 이미지로 빈 상태 표현
        SvgPicture.asset(
          "lib/core/assets/icons/icon_point_gray.svg",
          width: 38,
          height: 38,
        ),
        SizedBox(height: 16),
        Text(
          '구매/환불 포인트가 없어요',
          style: AppTextStyles.regular14
              .copyWith(color: AppColors.textTertiaryColor),
        ),
      ],
    );
  }
}

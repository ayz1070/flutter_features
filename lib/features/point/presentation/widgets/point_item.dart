import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/formatter.dart';
import '../vm/point_view_model.dart';

class PointItem extends StatelessWidget {
  final PointViewModel pointViewModel;

  const PointItem({
    Key? key,
    required this.pointViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      margin: EdgeInsets.symmetric(horizontal: 20),
      // 좌우에 margin을 주어 divider의 길이를 줄임
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.dividerPrimaryColor),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Formatter.formatYearMonthDate(pointViewModel.createdAt),
            style: AppTextStyles.regular14.copyWith(
              color: AppColors.textPrimaryColor,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "[상품구매적립] [COSETIC PB] 2중 \n기능성 앰플 30ml (8월 기획 한정)",
                style: AppTextStyles.regular14.copyWith(
                  color: AppColors.textPrimaryColor,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${Formatter.formatPoint(pointViewModel.pointPrice)}",
                    style: AppTextStyles.semiBold14.copyWith(
                      color: pointViewModel.isEarned
                          ? AppColors.primaryColor
                          : AppColors.textTertiaryColor,
                    ),
                  ),

                ],
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "${Formatter.formatHourMinute(pointViewModel.createdAt)} | ${pointViewModel.isEarned ? '적립' : '차감'}",
            style: AppTextStyles.light12.copyWith(
              color: AppColors.textTertiaryColor,
            ),
          )
        ],
      ),
    );
  }
}

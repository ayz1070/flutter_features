import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import 'month_bottom_sheet.dart';

class MonthSelector extends StatelessWidget {
  const MonthSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            showDurationBottomSheet(context, _onDurationSelected);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "1개월",
                style: AppTextStyles.regular14
                    .copyWith(color: AppColors.textTertiaryColor),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: AppColors.textTertiaryColor,
                size: 15,
              ),

            ],
          ),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }

  void _onDurationSelected(String duration) {
    print('선택한 기간: $duration');
  }
}

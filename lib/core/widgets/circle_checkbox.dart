import 'package:flutter/material.dart';

import '../theme/colors.dart';

class CircleCheckbox extends StatelessWidget {
  final bool value;
  final void Function(bool?)? onChanged;

  const CircleCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onChanged != null) {
          onChanged!(!value);
        }
      },
      child: Container(
        width: 20.0,
        height: 20.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle, // 원형으로 변경
          color: value ? AppColors.checkedColor : AppColors.unCheckedColor, // 체크 상태에 따라 색 변경
          border: Border.all(
            color: value ? AppColors.checkedColor : AppColors.unCheckedIconColor,
            width: 1.0,
          ),
        ),
        child: Center(
          child: Icon(
            Icons.check,
            size: 13.0, // 작고 얇은 체크 아이콘
            color: value ? AppColors.checkedIconColor : AppColors.unCheckedIconColor,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../../core/theme/colors.dart';

class SmallIconButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  const SmallIconButton({required this.title, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: AppColors.borderPrimaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4), // 버튼 모서리 둥글게
        ),
        fixedSize: Size(91, 34), // 버튼 크기 고정
        padding: EdgeInsets.zero, // 패딩 제거
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // 내부 위젯이 크기에 맞게 조정
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4), // 적절한 패딩 설정
            child: Icon(
              icon,
              color: AppColors.textTertiaryColor,
              size: 16, // 아이콘 크기 축소
            ),
          ),
          Text(
            '$title',
            style: TextStyle(
              color: AppColors.textTertiaryColor,
              fontSize: 11, // 텍스트 크기 축소
            ),
          ),
        ],
      ),
    );
  }
}

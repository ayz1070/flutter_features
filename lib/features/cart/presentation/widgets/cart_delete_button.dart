import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class CartDeleteButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CartDeleteButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(width: 1.0), // 테두리 설정
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0), // 직각 테두리
        ),
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), // 텍스트 기준 패딩 설정
        minimumSize: Size(0, 0), // 최소 크기 제한 해제
        tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 터치 영역 최소화
      ),
      child: Text(
        '삭제',
        style: TextStyle(
          color: Colors.black, // 텍스트 색상
          fontSize: 11.0, // 텍스트 크기
          fontWeight: FontWeight.normal, // 텍스트 굵기
        ),
      ),
    );
  }
}

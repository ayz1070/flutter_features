import 'package:flutter/material.dart';

import '../../../../../core/theme/colors.dart';

class RedDot extends StatelessWidget {
  const RedDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width:4),
        Container(
          margin: EdgeInsets.only(bottom: 8),
          width: 4, // 원의 너비
          height: 4, // 원의 높이
          decoration: BoxDecoration(
            color: Color(0xFFE42838), // 원의 색상
            shape: BoxShape.circle, // 원 모양
          ),
        ),
      ],
    );

  }
}
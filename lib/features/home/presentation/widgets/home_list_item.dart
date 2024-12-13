import 'package:flutter/material.dart';
import 'package:flutter_features/core/theme/text_styles.dart';

class HomeListItem extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onPressed;

  const HomeListItem({super.key, required this.title, required this.imagePath, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 120, // 가로 크기 제한
        margin: const EdgeInsets.all(12.0), // 요소 간 여백
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Image.asset(
                "${imagePath}",
                fit: BoxFit.fitHeight,
              ),
            ),
            const SizedBox(height: 8.0), // 이미지와 텍스트 사이 여백
            Text(title, style: AppTextStyles.bold16,),
          ],
        ),
      ),
    );
  }
}
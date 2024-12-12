import 'package:flutter/material.dart';

class HomeListItem extends StatelessWidget {
  final String title;

  const HomeListItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150, // 가로 크기 제한
      margin: const EdgeInsets.all(8.0), // 요소 간 여백
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Image.network(
              "https://picsum.photos/200/300",
              fit: BoxFit.fitWidth,
            ),
          ),
          const SizedBox(height: 8.0), // 이미지와 텍스트 사이 여백
          Text(title),
        ],
      ),
    );
  }
}
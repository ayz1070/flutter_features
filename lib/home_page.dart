import 'package:flutter/material.dart';
import 'package:flutter_features/core/theme/colors.dart';
import 'package:flutter_features/core/widgets/home_widgets/home_list_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimaryColor,
      appBar: AppBar(
        title: const Text("안영준의 플러터 기능 모음집"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 텍스트를 왼쪽 정렬
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "쇼핑몰",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                HomeListItem(iconData: Icons.shopping_cart, title: "장바구니"),
                HomeListItem(iconData: Icons.favorite, title: "찜"),
                HomeListItem(iconData: Icons.history, title: "구매 내역"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

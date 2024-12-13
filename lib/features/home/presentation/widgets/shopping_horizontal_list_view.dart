import 'package:flutter/material.dart';
import 'package:flutter_features/core/routes/routes.dart';
import 'package:go_router/go_router.dart';

import 'home_list_item.dart';

class ShoppingHorizontalListView extends StatelessWidget {
  const ShoppingHorizontalListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          HomeListItem(
            title: "장바구니",
            imagePath: "assets/images/cart.webp",
            onPressed: () => context.push("/cart")
          ),
          HomeListItem(
              title: "포인트",
              imagePath: "assets/images/point.png",
              onPressed: () => context.push("/point")),
          HomeListItem(
              title: "등급",
              imagePath: "assets/images/grade.png",
              onPressed: () => context.push("/grade")),
          HomeListItem(
              title: "배송지 관리",
              imagePath: "assets/images/address.png",
              onPressed: () => context.push("/address")),
          HomeListItem(
              title: "리뷰",
              imagePath: "assets/images/review.png",
              onPressed: () => context.push("/review")),
        ],
      ),
    );
  }
}

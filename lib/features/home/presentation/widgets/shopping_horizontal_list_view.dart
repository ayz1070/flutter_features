import 'package:flutter/material.dart';

import 'home_list_item.dart';

class ShoppingHorizontalListView extends StatelessWidget {

  const ShoppingHorizontalListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          HomeListItem(title: "장바구니"),
          HomeListItem(title: "포인트"),
          HomeListItem(title: "등급"),
          HomeListItem(title: "배송지 관리"),
          HomeListItem(title: "리뷰"),

        ],
      ),
    );
  }
}

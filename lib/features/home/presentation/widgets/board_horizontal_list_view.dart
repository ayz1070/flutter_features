import 'package:flutter/material.dart';

import 'home_list_item.dart';

class BoardHorizontalListView extends StatelessWidget {

  const BoardHorizontalListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          HomeListItem(title: "게시판"),
          HomeListItem(title: "테스트"),
          HomeListItem(title: "아무거나"),
          HomeListItem(title: "룰루랄라"),
        ],
      ),
    );
  }
}

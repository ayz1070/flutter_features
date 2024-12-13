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
        children:  [
          HomeListItem(title: "게시판",imagePath: "assets/images/board.png", onPressed: (){},),
        ],
      ),
    );
  }
}

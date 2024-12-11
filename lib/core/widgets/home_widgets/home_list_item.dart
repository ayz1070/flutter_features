import 'package:flutter/material.dart';

class HomeListItem extends StatelessWidget {
  final IconData iconData;
  final String title;

  const HomeListItem({super.key, required this.iconData, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          child: Icon(iconData),
        ),
        Text(title),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import 'grade_card.dart';

class GradeCardList extends StatelessWidget {
  const GradeCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        GradeCard(),
        GradeCard(),
      ],
    );
  }
}

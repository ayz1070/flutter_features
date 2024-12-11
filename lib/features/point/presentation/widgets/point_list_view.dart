import 'package:flutter/material.dart';
import 'package:flutter_features/features/point/presentation/widgets/point_item.dart';

import '../vm/point_view_model.dart';

class PointListView extends StatelessWidget {
  final List<PointViewModel> pointViewModels;

  const PointListView({
    required this.pointViewModels,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //MonthSelector(),
        Expanded(
          child: ListView.builder(
            itemCount: pointViewModels.length,
            itemBuilder: (context, index) {
              final pointViewModel = pointViewModels[index];
              return PointItem(pointViewModel: pointViewModel);
            },
          ),
        ),
      ],
    );
  }
}

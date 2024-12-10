import 'package:flutter/material.dart';

import '../../../../core/widgets/circle_checkbox.dart';

class SelectAllCheckbox extends StatelessWidget {
  final bool isSelected;
  final ValueChanged<bool> onToggle;

  const SelectAllCheckbox({
    Key? key,
    required this.isSelected,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleCheckbox(
            value: isSelected,
            onChanged: (bool? value) {
              onToggle(value ?? false);
            },
          ),
          SizedBox(width: 8,),
          Text('전체 상품',
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

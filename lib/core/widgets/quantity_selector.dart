import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/text_styles.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final ValueChanged<int> onQuantityChanged;

  const QuantitySelector({
    Key? key,
    required this.quantity,
    required this.onQuantityChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 74,
      height: 24,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.secondaryColorDark),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              if (quantity > 1) {
                onQuantityChanged(quantity - 1);
              }
            },
            child: Container(
              width: 23,
              height: 24,
              child: Icon(
                Icons.remove,
                size: 12,
              ),
            ),
          ),
          Container(
            color: AppColors.secondaryColorDark,
            width: 1,
            height: 24,
          ),
          Container(
            width: 24,
            child: Center(
              child: Text(
                '$quantity',
              ),
            ),
          ),
          Container(
            color:AppColors.secondaryColorDark,
            width: 1,
            height: 24,
          ),
          GestureDetector(
            onTap: () {
              onQuantityChanged(quantity + 1);
            },
            child: Container(
              width: 23,
              height: 24,
              child: Icon(
                Icons.add,
                size: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
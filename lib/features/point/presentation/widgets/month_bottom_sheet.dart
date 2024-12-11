import 'package:flutter/material.dart';

class MonthBottomSheet extends StatelessWidget {
  final void Function(String selectedDuration) onSelect;

  const MonthBottomSheet({
    Key? key,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '기간',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.close),
            ],
          ),
          
          SizedBox(height: 8),
          _buildOption(context, '1개월'),
          _buildOption(context, '3개월'),
          _buildOption(context, '6개월'),
          _buildOption(context, '12개월'),
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context, String duration) {
    return ListTile(
      title: Text(
        duration,
        style: TextStyle(fontSize: 16),
      ),
      onTap: () {
        onSelect(duration);
        Navigator.pop(context);
      },
    );
  }
}

void showDurationBottomSheet(BuildContext context, Function(String) onSelect) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => MonthBottomSheet(onSelect: onSelect),
  );
}

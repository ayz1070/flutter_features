import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  final String name;
  final String addressName;
  final String address;
  final String phone;
  final bool isDefault;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  AddressCard({
    required this.name,
    required this.addressName,
    required this.address,
    required this.phone,
    required this.isDefault,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8.0),
                if (isDefault)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.orange[100],
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      '기본 배송지',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 4.0),
            Text(
              addressName,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              address,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              phone,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: onDelete,
                  child: Text('삭제'),
                ),
                ElevatedButton(
                  onPressed: onEdit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[50],
                  ),
                  child: Text(
                    '수정',
                    style: TextStyle(color: Colors.pink),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
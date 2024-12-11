import 'package:flutter/material.dart';
import '../../../../../core/theme/text_styles.dart';

class AddressButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed; // 클릭 이벤트를 위한 콜백 함수

  const AddressButton({Key? key, required this.title ,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8,vertical: 20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed, // 전달받은 클릭 이벤트 콜백
          child: Text(
            '$title',
            style: AppTextStyles.medium15,
          ),
        ),
      ),
    );
  }
}
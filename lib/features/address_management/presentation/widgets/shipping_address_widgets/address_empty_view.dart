import 'package:flutter/material.dart';
import '../../../../../core/theme/text_styles.dart';

class AddressEmptyView extends StatelessWidget {
  const AddressEmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '등록된 배송지가 없습니다',
        style: AppTextStyles.bodyText,
      ),
    );
  }
}
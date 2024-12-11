import 'package:flutter/material.dart';
import 'package:kpostal_web/kpostal_web.dart'; // 웹용 라이브러리 사용

class PostalView{
  @override
  Widget buildPostalView(BuildContext context, Function(String, String) onComplete) {
    print('WebPostalView 사용 중');

    return KakaoAddressWidget(
      onComplete: (result) {
        onComplete(result.address, result.postCode);
      },
      onClose: () {
        Navigator.of(context).pop();
      },
    );
  }
}
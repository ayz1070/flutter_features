// kpostal_mobile.dart
import 'package:flutter/material.dart';
import 'package:kpostal/kpostal.dart';


class PostalView {
  @override
  Widget buildPostalView(BuildContext context, Function(String, String) onComplete) {

    print('MobilePostalView 사용 중');
    return KpostalView(
      callback: (Kpostal result) {
        onComplete(result.address, result.postCode);
      },
    );
  }
}
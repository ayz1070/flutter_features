import 'package:flutter_features/features/address_management/presentation/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';

class PostalView {
  @override
  Widget buildPostalView(
      BuildContext context, Function(String, String) onComplete) {
    return CustomDialog(
      title: "지원하지 않는 os 입니다",
      content: "모바일 혹은 웹으로 접속해주세요",
      onConfirm: Navigator.of(context).pop,
      confirmTitle: '확인',
    );
  }
}

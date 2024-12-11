import 'package:flutter/material.dart';

import '../../../../../core/theme/text_styles.dart';

class ReviewTextField extends StatefulWidget {
  final String? initialValue;
  final Function(String) onChanged;

  const ReviewTextField({this.initialValue, required this.onChanged});

  @override
  _ReviewTextFieldState createState() => _ReviewTextFieldState();
}

class _ReviewTextFieldState extends State<ReviewTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(covariant ReviewTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 초기값이 변경된 경우에만 TextEditingController의 텍스트와 커서를 업데이트
    if (widget.initialValue != oldWidget.initialValue) {
      _controller.value = _controller.value.copyWith(
        text: widget.initialValue ?? '',
        selection: TextSelection.collapsed(offset: (widget.initialValue ?? '').length),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      maxLines: 3,
      onChanged: (text) {
        widget.onChanged(text); // 텍스트 변경 시 외부 콜백 호출
      },
      decoration: InputDecoration(
        hintText: '다른 고객들에게 도움이 되도록 상품에 대한 솔직한 평가를 남겨주세요.',
        border: OutlineInputBorder(),
        hintStyle: AppTextStyles.regular14,
      ),
    );
  }
}
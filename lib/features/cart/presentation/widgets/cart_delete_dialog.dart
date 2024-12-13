import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';

class CartDeleteDialog extends StatelessWidget {
  final String cartProductId;
  final Function(String cartProductId) onDeleteItem;

  const CartDeleteDialog({
    super.key,
    required this.cartProductId,
    required this.onDeleteItem,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)), // 각지게 설정
      ),
      contentPadding: const EdgeInsets.fromLTRB(24.0, 30.0, 24.0, 0.0), // 여백 조정
      actionsPadding: EdgeInsets.zero, // 버튼 영역 여백 제거
      buttonPadding: EdgeInsets.zero, // 버튼 내부 여백 제거
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "선택한 항목을 삭제하시겠어요?",
            style: AppTextStyles.regular15,
            textAlign: TextAlign.center, // 텍스트 중앙 정렬
          ),
          const SizedBox(height: 10),
        ],
      ),
      actions: [
        Container(
          height: 48, // 버튼 높이 설정
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.textPrimaryColor,
                    backgroundColor: AppColors.buttonTertiaryColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // 각진 버튼
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // 다이얼로그 닫기
                  },
                  child: const Text("취소"),
                ),
              ),
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white, // 텍스트 색상
                    backgroundColor: AppColors.buttonSecondaryColor, // 버튼 배경색
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // 각진 버튼
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // 다이얼로그 닫기
                    onDeleteItem(cartProductId); // 삭제 콜백 호출
                  },
                  child: const Text("확인"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

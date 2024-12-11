import 'package:flutter/material.dart';

import '../../../../core/theme/app_screen_size.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmTitle;
  final String? cancelTitle;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  CustomDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.confirmTitle,
    required this.onConfirm,
    this.cancelTitle,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.backgroundPrimaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: AppScreenSize.webMaxSize - 100, // 웹에서 최대 크기 제어
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 28, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: AppTextStyles.semiBold16,
              ),
              SizedBox(height: 12),
              Text(
                content,
                style: AppTextStyles.regular14.copyWith(
                  color: Color(0xFF4C495E),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end, // 버튼들이 오른쪽에 배치되도록 변경
                children: [
                  // cancelTitle이 null이 아니면 취소 버튼 표시
                  if (cancelTitle != null && onCancel != null) ...[
                    Expanded(
                      child: TextButton(
                        onPressed: onCancel,
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.buttonSecondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: EdgeInsets.fromLTRB(57, 17, 57, 17),
                        ),
                        child: Text(
                          cancelTitle!,
                          style: AppTextStyles.medium15,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                  ],
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onConfirm,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        backgroundColor: AppColors.primaryColor,
                        padding: EdgeInsets.fromLTRB(57, 17, 57, 17),
                      ),
                      child: Text(
                        confirmTitle,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
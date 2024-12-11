import 'package:flutter/material.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/text_styles.dart';

class ReviewAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onBackPressed;
  final PreferredSizeWidget? bottomWidget;

  const ReviewAppBar({
    Key? key,
    required this.title,
    required this.onBackPressed,
    this.bottomWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundPrimaryColor,
      title: Text(title, style: AppTextStyles.bold18),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: onBackPressed,
      ),
      bottom: bottomWidget,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    kToolbarHeight + (bottomWidget?.preferredSize.height ?? 0),
  );
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';

class AddressAppBar extends StatelessWidget implements PreferredSizeWidget{
  VoidCallback onPressed;
  String title;

  AddressAppBar({super.key, required this.title,   required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.toolbarColor,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: onPressed,
      ),
      title: Text(
        title,
        style: AppTextStyles.semiBold18,
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // 기본 AppBar 높이 설정
}
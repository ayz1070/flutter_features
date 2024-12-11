import 'package:flutter/material.dart';

import '../../../../../core/theme/colors.dart';

class ReviewTabBar extends StatelessWidget implements PreferredSizeWidget {
  final Color indicatorColor;
  final Color labelColor;
  final Color unselectedLabelColor;
  final EdgeInsetsGeometry margin;

  const ReviewTabBar({
    Key? key,
    this.indicatorColor = Colors.black,
    this.labelColor = Colors.black,
    this.unselectedLabelColor = const Color(0xFFACB2B5),
    this.margin = const EdgeInsets.symmetric(horizontal: 20),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundPrimaryColor,
      margin: margin,
      child: TabBar(
        dividerColor: Colors.transparent,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 2.0, color: indicatorColor),
          insets: const EdgeInsets.symmetric(horizontal: -10),
        ),
        labelColor: labelColor,
        unselectedLabelColor: unselectedLabelColor,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        tabs: [
          Tab(text: '리뷰 작성'), // 예: localization 적용: AppLocalizations.of(context).writeReview
          Tab(text: '작성한 리뷰'), // 예: localization 적용: AppLocalizations.of(context).writtenReviews
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(48);
}


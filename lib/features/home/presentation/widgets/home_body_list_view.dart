import 'package:flutter/material.dart';
import 'package:flutter_features/core/theme/text_styles.dart';
import 'package:flutter_features/features/home/presentation/widgets/profile_card.dart';
import 'package:flutter_features/features/home/presentation/widgets/shopping_horizontal_list_view.dart';

import 'board_horizontal_list_view.dart';


class HomeBodyListView extends StatelessWidget {
  const HomeBodyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          /// 쇼핑몰
          Text(
            "쇼핑몰",
            style: AppTextStyles.bold20.copyWith(
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16),
          ShoppingHorizontalListView(),
          SizedBox(height: 16),
      
          /// 게시판
          Text(
            "커뮤니티",
            style: AppTextStyles.bold20.copyWith(
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16),
          BoardHorizontalListView(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class PointSkeletonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimaryColor,
        title: Container(
          height: 20,
          width: 120,
          decoration: BoxDecoration(
            color: AppColors.skeletonPrimaryColor,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        centerTitle: true,
        leading: Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            color: AppColors.skeletonPrimaryColor,
            shape: BoxShape.circle,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 포인트 요약 섹션
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.skeletonPrimaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          // 리뷰 작성 버튼 및 탭 바 섹션
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.skeletonPrimaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          // 탭 바 스켈레톤
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(3, (index) {
                return Container(
                  height: 30,
                  width: 80,
                  decoration: BoxDecoration(
                    color: AppColors.skeletonPrimaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
              }),
            ),
          ),
          Divider(
            thickness: 1,
            height: 1,
            color: AppColors.dividerPrimaryColor,
          ),
          // 리스트 스켈레톤
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.skeletonPrimaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      // 왼쪽 아이콘 스켈레톤
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: AppColors.skeletonSecondaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 12),
                      // 텍스트 스켈레톤
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 16,
                              width: 200,
                              color: AppColors.skeletonSecondaryColor,
                            ),
                            SizedBox(height: 8),
                            Container(
                              height: 12,
                              width: 150,
                              color: AppColors.skeletonSecondaryColor,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12),
                      // 오른쪽 포인트 스켈레톤
                      Container(
                        height: 16,
                        width: 50,
                        color: AppColors.skeletonSecondaryColor,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

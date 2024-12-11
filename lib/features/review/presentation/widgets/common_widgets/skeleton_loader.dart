import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ReviewSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 10, // 샘플 항목 수
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 상단 구매 날짜와 아이콘 부분
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 120,
                          height: 14,
                          color: Colors.white,
                        ),
                        Container(
                          width: 24,
                          height: 24,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    // 하단 이미지와 텍스트
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 이미지 부분
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: 70,
                            height: 70,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 12.0),
                        // 텍스트 부분
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 16,
                                color: Colors.white,
                              ),
                              SizedBox(height: 4.0),
                              Container(
                                width: 100,
                                height: 12,
                                color: Colors.white,
                              ),
                              SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
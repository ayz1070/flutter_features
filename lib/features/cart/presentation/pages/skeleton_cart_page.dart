import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart'; // Shimmer 효과를 위해 사용

class SkeletonCartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: 1, // 상품 항목 하나의 스켈레톤
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    // 상품 카드 스켈레톤
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 체크박스 스켈레톤
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: 20,
                              height: 20,
                              color: Colors.grey[300],
                            ),
                          ),
                          SizedBox(width: 8),
                          // 이미지 스켈레톤
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey[300],
                            ),
                          ),
                          SizedBox(width: 16),
                          // 텍스트 스켈레톤
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    width: double.infinity,
                                    height: 16,
                                    color: Colors.grey[300],
                                  ),
                                ),
                                SizedBox(height: 8),
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    width: 120,
                                    height: 16,
                                    color: Colors.grey[300],
                                  ),
                                ),
                                SizedBox(height: 16),
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    width: 80,
                                    height: 16,
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                );
              },
            ),
          ),
          // 주문 요약 스켈레톤
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              children: [
                _buildSummarySkeletonRow(),
                SizedBox(height: 8),
                _buildSummarySkeletonRow(),
                SizedBox(height: 8),
                _buildSummarySkeletonRow(),
                SizedBox(height: 8),
                _buildSummarySkeletonRow(
                  highlight: true, // 총 결제 금액 강조
                ),
              ],
            ),
          ),
          // 결제 버튼 스켈레톤
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              margin: EdgeInsets.all(16),
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySkeletonRow({bool highlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: 120,
            height: 16,
            color: Colors.grey[300],
          ),
        ),
        Shimmer.fromColors(
          baseColor: highlight ? Colors.grey[400]! : Colors.grey[300]!,
          highlightColor: highlight ? Colors.grey[200]! : Colors.grey[100]!,
          child: Container(
            width: 80,
            height: 16,
            color: Colors.grey[300],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ReviewAddSkeleton extends StatelessWidget {
  const ReviewAddSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 제품 정보 스켈레톤
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildShimmerContainer(width: 64, height: 64, borderRadius: 12),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildShimmerContainer(width: 200, height: 20),
                  SizedBox(height: 8),
                  _buildShimmerContainer(width: 150, height: 20),
                ],
              ),
            ],
          ),
          SizedBox(height: 48),
          _buildShimmerContainer(width: double.infinity, height: 20),
          SizedBox(height: 16),
          _buildShimmerContainer(width: 100, height: 20),
          SizedBox(height: 16),
          // 별점 스켈레톤
          Row(
            children: List.generate(5, (index) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _buildShimmerContainer(width: 30, height: 30, borderRadius: 15),
            )),
          ),
          SizedBox(height: 16),
          _buildShimmerContainer(width: double.infinity, height: 20),
          SizedBox(height: 16),
          // 텍스트 필드 스켈레톤
          _buildShimmerContainer(width: double.infinity, height: 100, borderRadius: 8),
          SizedBox(height: 16),
          _buildShimmerContainer(width: 120, height: 20),
          SizedBox(height: 12),
          // 이미지 첨부 스켈레톤
          Row(
            children: List.generate(3, (index) => Padding(
              padding: const EdgeInsets.only(right: 12),
              child: _buildShimmerContainer(width: 64, height: 64, borderRadius: 8),
            )),
          ),
          Spacer(),
          // 완료 버튼 스켈레톤
          _buildShimmerContainer(width: double.infinity, height: 50, borderRadius: 8),
        ],
      ),
    );
  }

  Widget _buildShimmerContainer({double width = double.infinity, double height = 20, double borderRadius = 0}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
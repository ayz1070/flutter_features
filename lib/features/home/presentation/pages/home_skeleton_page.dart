import 'package:flutter/material.dart';

class HomeSkeletonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('플러터 기능'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 프로필 카드
              SkeletonCard(),
              SizedBox(height: 20),
              // 쇼핑몰 섹션
              Text(
                '쇼핑몰',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SkeletonTile(),
                  SkeletonTile(),
                  SkeletonTile(),
                ],
              ),
              SizedBox(height: 20),
              // 커뮤니티 섹션
              Text(
                '커뮤니티',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 10),
              SkeletonTile(),
            ],
          ),
        ),
      ),
    );
  }
}

class SkeletonCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey[900], // 더 어두운 톤
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey[800], // 어두운 원
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.grey[800], // 텍스트 박스
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: 150,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.grey[800], // 텍스트 박스
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SkeletonTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey[900], // 더 어두운 배경
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: 80,
          height: 12,
          decoration: BoxDecoration(
            color: Colors.grey[800], // 텍스트 박스
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
  }
}
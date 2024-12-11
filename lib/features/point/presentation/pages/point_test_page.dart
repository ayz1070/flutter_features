import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_features/features/point/presentation/pages/point_page.dart';

import '../../../../core/utils/test_data.dart';
import '../../data/datasources/point_data_source.dart';
import '../../data/mapper/point_mapper.dart';
import '../../data/model/point_model.dart';
import '../../domain/entities/point_type.dart';
import '../../domain/repositories/point_repository.dart';

class PointTestPage extends StatefulWidget {
  const PointTestPage({super.key});

  @override
  State<PointTestPage> createState() => _PointTestPageState();
}

class _PointTestPageState extends State<PointTestPage> {
  final String userId = TestData.loginedUser.id;

  @override
  Widget build(BuildContext context) {
    final pointModel = PointModel(
        userId: userId,
        reviewId: "test_review_id",
        pointPrice: 200,
        pointType: PointType.EARNED,
        createdAt: DateTime.now());

    final pointEntity = PointMapper.toEntity(pointModel);

    final pointRemoteDataSource = context.read<PointDataSource>();
    final pointRepositoryImpl = context.read<PointRepository>();

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Text("포인트", style: TextStyle(fontSize: 20)),
          OutlinedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PointPage()));
            },
            child: Text("포인트 화면 이동"),
          ),
          // -----------------------------------------------------------
          Divider(),
          Text("DataSource", style: TextStyle(fontSize: 20)),
          Divider(),
          Text("create"),
          OutlinedButton(
            onPressed: () async {
              await pointRemoteDataSource.savePoint(pointModel);
            },
            child: Text("포인트 savePoint"),
          ),
          Text("fetch"),
          OutlinedButton(
            onPressed: () async {
              final pointModel = await pointRemoteDataSource
                  .fetchPointById("vVU82bqBVfRAe6e1aSVE");
              showSnackBar(context, pointModel.id!);
            },
            child: Text("포인트 fetchPointById"),
          ),
          OutlinedButton(
            onPressed: () async {
              final points =
                  await pointRemoteDataSource.fetchPointsByUserId(userId);
              showSnackBar(context, "포인트 ${points.length.toString()}개");
            },
            child: Text("포인트 fetchPointsByUserId"),
          ),
          OutlinedButton(
            onPressed: () async {
              final points =
                  await pointRemoteDataSource.fetchEarnedPointsByUserId(userId);
              showSnackBar(context, "적립된 포인트 ${points.length.toString()}개");
            },
            child: Text("포인트 fetchEarnedPointsByUserId"),
          ),
          OutlinedButton(
            onPressed: () async {
              final points =
                  await pointRemoteDataSource.fetchUsedPointByUserId(userId);
              showSnackBar(context, "사용한 포인트 ${points.length.toString()}개");
            },
            child: Text("포인트 fetchUsedPointByUserId"),
          ),
          Divider(),
          Text("update"),
          OutlinedButton(
            onPressed: () async {
              final points =
                  await pointRemoteDataSource.fetchPointsByUserId(userId);

              final newPoint =
                  points[0].copyWith(pointPrice: points[0].pointPrice + 1);
              final updatedPointModel =
                  await pointRemoteDataSource.updatePoint(newPoint);
              showSnackBar(
                  context, "가격 업데이트 : ${updatedPointModel.pointPrice}");
            },
            child: Text("포인트 update"),
          ),
          Divider(),
          Text("delete"),
          OutlinedButton(
            onPressed: () async {
              final points =
                  await pointRemoteDataSource.fetchPointsByUserId(userId);

              final deletedPoint =
                  await pointRemoteDataSource.deletePoint(points[0].id!);
              showSnackBar(context, "포인트 삭제 : ${deletedPoint}");
            },
            child: Text("포인트 deletePoint"),
          ),

          // -----------------------------------------------------------

          Divider(),
          Text(
            "Repository",
            style: TextStyle(fontSize: 20),
          ),

          Text("create"),
          OutlinedButton(
            onPressed: () async {
              await pointRepositoryImpl.savePoint(pointEntity);
            },
            child: Text("포인트 savePoint"),
          ),
          Text("fetch"),
          OutlinedButton(
            onPressed: () async {
              final pointModel = await pointRepositoryImpl
                  .fetchPointById("vVU82bqBVfRAe6e1aSVE");
              showSnackBar(context, pointModel.id!);
            },
            child: Text("포인트 fetchPointById"),
          ),
          OutlinedButton(
            onPressed: () async {
              final points =
                  await pointRepositoryImpl.fetchPointsByUserId(userId);
              showSnackBar(context, "포인트 ${points.length.toString()}개");
            },
            child: Text("포인트 fetchPointsByUserId"),
          ),
          OutlinedButton(
            onPressed: () async {
              final points =
                  await pointRepositoryImpl.fetchEarnedPointsByUserId(userId);
              showSnackBar(context, "적립된 포인트 ${points.length.toString()}개");
            },
            child: Text("포인트 fetchEarnedPointsByUserId"),
          ),
          OutlinedButton(
            onPressed: () async {
              final points =
                  await pointRepositoryImpl.fetchUsedPointByUserId(userId);
              showSnackBar(context, "사용한 포인트 ${points.length.toString()}개");
            },
            child: Text("포인트 fetchUsedPointByUserId"),
          ),
          Divider(),
          Text("update"),
          OutlinedButton(
            onPressed: () async {
              final points =
                  await pointRepositoryImpl.fetchPointsByUserId(userId);

              final newPoint =
                  points[0].copyWith(pointPrice: points[0].pointPrice + 1);
              final updatedPointModel =
                  await pointRepositoryImpl.updatePoint(newPoint);
              showSnackBar(
                  context, "가격 업데이트 : ${updatedPointModel.pointPrice}");
            },
            child: Text("포인트 update"),
          ),
          Divider(),
          Text("delete"),
          OutlinedButton(
            onPressed: () async {
              final points =
                  await pointRepositoryImpl.fetchPointsByUserId(userId);

              final deletedPoint =
                  await pointRepositoryImpl.deletePoint(points[0].id!);
              showSnackBar(context, "포인트 삭제 : ${deletedPoint}");
            },
            child: Text("포인트 deletePoint"),
          ),

          // --------------------------------------------------------------
          Divider(),
          Text("시나리오"),
          OutlinedButton(
            onPressed: () async {
              final earnedPointModel = PointModel(
                  userId: userId,
                  reviewId: "test_review_id",
                  pointPrice: 1000,
                  pointType: PointType.EARNED,
                  createdAt: DateTime.now());
              await pointRemoteDataSource.savePoint(earnedPointModel);
            },
            child: Text("포인트 적립"),
          ),
          OutlinedButton(
            onPressed: () async {
              final usedPointModel = PointModel(
                  userId: userId,
                  reviewId: "test_review_id",
                  pointPrice: -500,
                  pointType: PointType.USED,
                  createdAt: DateTime.now(),
                  usedAt: DateTime.now());
              await pointRemoteDataSource.savePoint(usedPointModel);
            },
            child: Text("포인트 사용"),
          ),

          OutlinedButton(
            onPressed: () async {
              final expiredPointModel = PointModel(
                userId: userId,
                reviewId: "test_review_id",
                pointPrice: -500,
                pointType: PointType.EXPIRED,
                createdAt: DateTime(
                  DateTime.now().year - 2,
                  DateTime.now().month,
                  DateTime.now().day,
                ),
              );
              await pointRemoteDataSource.savePoint(expiredPointModel);
            },
            child: Text("만료 포인트 생성"),
          ),
        ],
      ),
    );
  }

  void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: Duration(seconds: 1), // 표시 시간
      ),
    );
  }
}

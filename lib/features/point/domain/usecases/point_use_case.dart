import 'package:logger/logger.dart';

import '../entities/point_entity.dart';
import '../repositories/point_repository.dart';

final Logger logger = Logger();

abstract class PointUseCase<Type, Params> {
  Future<Type> call(Params params);
}
/// read
class FetchPointsByUserIdUseCase extends PointUseCase<List<PointEntity>, String> {
  final PointRepository pointRepository;

  FetchPointsByUserIdUseCase({required this.pointRepository});

  @override
  Future<List<PointEntity>> call(String userId) async {
    try {
      // 데이터 가져오기
      final points = await pointRepository.fetchPointsByUserId(userId);

      // 정렬 수행 (createdAt 기준 오름차순)
      points.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      logger.i('Points fetched and sorted successfully for userId: ${userId}');

      return points;
    } catch (e, stackTrace) {
      logger.e('Error fetching points for userId: ${userId}', error: e, stackTrace: stackTrace);
      return [];
    }
  }
}


class FetchEarnedPointsByUserIdUseCase extends PointUseCase<List<PointEntity>, String> {
  final PointRepository pointRepository;

  FetchEarnedPointsByUserIdUseCase({required this.pointRepository});

  @override
  Future<List<PointEntity>> call(String userId) async {
    try {
      final points = await pointRepository.fetchEarnedPointsByUserId(userId);
      logger.i('Earned points fetched successfully for userId: ${userId}');
      return points;
    } catch (e, stackTrace) {
      logger.e('Error fetching earned points for userId: ${userId}');
      return [];
    }
  }
}

class FetchUsedPointByUserIdUseCase extends PointUseCase<List<PointEntity>, String> {
  final PointRepository pointRepository;

  FetchUsedPointByUserIdUseCase({required this.pointRepository});

  @override
  Future<List<PointEntity>> call(String userId) async {
    try {
      final points = await pointRepository.fetchUsedPointByUserId(userId);
      logger.i('Used points fetched successfully for userId: ${userId}');
      return points;
    } catch (e, stackTrace) {
      logger.e('Error fetching used points for userId: ${userId}');
      return [];
    }
  }
}


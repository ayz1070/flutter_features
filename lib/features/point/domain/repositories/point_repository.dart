import '../entities/point_entity.dart';

abstract class PointRepository{
  // create
  Future<void> savePoint(PointEntity pointEntity);

  // read
  Future<PointEntity> fetchPointById(String pointId);
  Future<List<PointEntity>> fetchPointsByUserId(String userId);
  Future<List<PointEntity>> fetchEarnedPointsByUserId(String userId);
  Future<List<PointEntity>> fetchUsedPointByUserId(String userId);

  // update
  Future<PointEntity> updatePoint(PointEntity point);
  Future<void> updateToExpiredPoint(String pointId);

  // delete
  Future<PointEntity> deletePoint(String pointId);
}
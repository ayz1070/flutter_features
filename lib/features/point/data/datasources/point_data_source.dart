
import '../model/point_model.dart';

abstract class PointDataSource{
  // create
  Future<void> savePoint(PointModel point);

  // read
  Future<PointModel> fetchPointById(String pointId);
  Future<List<PointModel>> fetchPointsByUserId(String userId);
  Future<List<PointModel>> fetchEarnedPointsByUserId(String userId);
  Future<List<PointModel>> fetchUsedPointByUserId(String userId);

  // update
  Future<PointModel> updatePoint(PointModel point);
  Future<void> updateToExpiredPoint(String pointId);

  // delete
  Future<PointModel> deletePoint(String pointId);
}

import '../../domain/entities/point_entity.dart';
import '../../domain/repositories/point_repository.dart';
import '../datasources/point_data_source.dart';
import '../mapper/point_mapper.dart';

class PointRepositoryImpl implements PointRepository {
  final PointDataSource dataSource;

  PointRepositoryImpl({required this.dataSource});

  /// create
  @override
  Future<void> savePoint(PointEntity pointEntity) async {
    try {
      final pointModel = PointMapper.toModel(pointEntity);
      await dataSource.savePoint(pointModel);
    } catch (e) {
      rethrow;
    }
  }

  /// read
  @override
  Future<PointEntity> fetchPointById(String pointId) async {
    try {
      final pointModel = await dataSource.fetchPointById(pointId);
      final pointEntity = PointMapper.toEntity(pointModel);
      return pointEntity;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PointEntity>> fetchPointsByUserId(String userId) async {
    try {
      final pointModels = await dataSource.fetchPointsByUserId(userId);
      final pointEntities = pointModels.map(PointMapper.toEntity).toList();
      return pointEntities;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PointEntity>> fetchEarnedPointsByUserId(String userId) async {
    try {
      final pointModels = await dataSource.fetchEarnedPointsByUserId(userId);
      final pointEntities = pointModels.map(PointMapper.toEntity).toList();
      return pointEntities;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PointEntity>> fetchUsedPointByUserId(String userId) async {
    try {
      final pointModels = await dataSource.fetchUsedPointByUserId(userId);
      final pointEntities = pointModels.map(PointMapper.toEntity).toList();
      return pointEntities;
    } catch (e) {
      rethrow;
    }
  }

  /// update
  @override
  Future<PointEntity> updatePoint(PointEntity pointEntity) async {
    try {
      final pointModel = PointMapper.toModel(pointEntity);
      await dataSource.updatePoint(pointModel);
      return pointEntity;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateToExpiredPoint(String pointId) async{
    try {
      await dataSource.updateToExpiredPoint(pointId);
    } catch (e) {
      rethrow;
    }
  }

  /// delete
  @override
  Future<PointEntity> deletePoint(String pointId) async{
    try{
      final deletedPoint = await dataSource.deletePoint(pointId);
      return PointMapper.toEntity(deletedPoint);
    }catch(e){
      rethrow;
    }
  }
}

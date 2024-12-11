import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_features/features/point/data/datasources/point_data_source.dart';
import 'package:logger/logger.dart';


import '../../../../core/exceptions/point_exception.dart';
import '../../../../core/utils/test_data.dart';
import '../../domain/entities/point_type.dart';
import '../mapper/point_mapper.dart';
import '../model/point_model.dart';

class PointRemoteDataSource implements PointDataSource {
  final FirebaseFirestore firestore;
  final String userId = TestData.loginedUser.id;
  final Logger logger = Logger(); // Logger 인스턴스 생성

  PointRemoteDataSource({required this.firestore});

  // create
  @override
  Future<PointModel> savePoint(PointModel pointModel) async {
    final pointRef = firestore.collection('points').doc();
    //final pointRef = firestore.collection('users').doc(userId).collection('points').doc();

    final newPointModel = pointModel.copyWith(id: pointRef.id, userId: userId);

    try {
      await pointRef.set(PointMapper.toMap(newPointModel));
      logger.i('savePoint 성공, pointId : ${newPointModel.id}');
      return newPointModel;
    } catch (e, stackTrace) {
      logger.e('savePoint 에러', stackTrace: stackTrace);
      rethrow;
    }
  }

  // read
  @override
  Future<PointModel> fetchPointById(String pointId) async {
    try {
      final snapshot = await firestore.collection('points').doc(pointId).get();

      if (!snapshot.exists) {
        throw PointNotFoundException(pointId,
            origin: "DATASOURCE : fetchPointById");
      }
      final pointModel = PointMapper.fromMap(snapshot.data()!, id: snapshot.id);
      logger.i('fetchPointById 성공, pointId : ${pointModel.id}');
      return pointModel;
    } catch (e, stackTrace) {
      logger.e('fetchPointById 에러', stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<List<PointModel>> fetchPointsByUserId(String userId) async {
    try {
      final snapshot = await firestore
          .collection('points')
          .where('userId', isEqualTo: userId)
          .get();

      // 데이터가 없으면 빈 리스트 반환
      if (snapshot.docs.isEmpty) {
        logger.i('fetchPointsByUserId: 유저 $userId에 대한 포인트가 없습니다.');
        return [];
      }

      final points = snapshot.docs.map((doc) {
        return PointMapper.fromMap(doc.data(), id: doc.id);
      }).toList();

      logger.i('fetchPointsByUserId: 유저 $userId에 대한 포인트 ${points.length}개를 성공적으로 가져왔습니다.');
      return points;

    } catch (e, stackTrace) {
      logger.e('fetchPointsByUserId: 유저 $userId에 대한 포인트를 가져오는 중 에러 발생.', error: e, stackTrace: stackTrace);
      throw PointFirestoreException('유저 $userId에 대한 포인트를 가져오는 중 에러 발생.', origin: 'fetchPointsByUserId');
    }
  }


  @override
  Future<List<PointModel>> fetchEarnedPointsByUserId(String userId) async {
    try {
      // Firestore에서 userId와 pointType이 'EARNED'인 데이터만 필터링
      final snapshot = await firestore
          .collection('points')
          .where('userId', isEqualTo: userId)
          .where('pointType', isEqualTo: 'earned') // EARNED 상태 추가
          .get();

      // 데이터가 없으면 빈 리스트 반환
      if (snapshot.docs.isEmpty) {
        logger.i('fetchEarnedPointsByUserId: 유저 $userId에 대한 EARNED 포인트가 없습니다.');
        return [];
      }

      // PointMapper를 사용해 문서를 PointModel 리스트로 변환
      final points = snapshot.docs.map((doc) {
        return PointMapper.fromMap(doc.data(), id: doc.id);
      }).toList();

      logger.i(
          'fetchEarnedPointsByUserId: 유저 $userId에 대한 EARNED 포인트 ${points.length}개를 성공적으로 가져왔습니다.');
      return points;
    } catch (e, stackTrace) {
      // 예외 처리 및 로깅
      logger.e(
          'fetchEarnedPointsByUserId: Firestore에서 유저 $userId의 earned 포인트를 가져오는 중 에러 발생.',
          error: e,
          stackTrace: stackTrace);
      throw PointFirestoreException(
        'Firestore에서 유저 $userId의 EARNED 포인트를 가져오는 중 에러 발생.',
        origin: 'fetchEarnedPointsByUserId',
      );
    }
  }

  @override
  Future<List<PointModel>> fetchUsedPointByUserId(String userId) async {
    try {
      // Firestore에서 userId와 pointType이 'EARNED'인 데이터만 필터링
      final snapshot = await firestore
          .collection('points')
          .where('userId', isEqualTo: userId)
          .where('pointType', isEqualTo: 'used') // EARNED 상태 추가
          .get();

      // 데이터가 없으면 빈 리스트 반환
      if (snapshot.docs.isEmpty) {
        logger.i('fetchEarnedPointsByUserId: 유저 $userId에 대한 used 포인트가 없습니다.');
        return [];
      }

      // PointMapper를 사용해 문서를 PointModel 리스트로 변환
      final points = snapshot.docs.map((doc) {
        return PointMapper.fromMap(doc.data(), id: doc.id);
      }).toList();

      logger.i(
          'fetchEarnedPointsByUserId: 유저 $userId에 대한 used 포인트 ${points.length}개를 성공적으로 가져왔습니다.');
      return points;
    } catch (e, stackTrace) {
      // 예외 처리 및 로깅
      logger.e(
          'fetchEarnedPointsByUserId: Firestore에서 유저 $userId의 used 포인트를 가져오는 중 에러 발생.',
          error: e,
          stackTrace: stackTrace);
      throw PointFirestoreException(
        'Firestore에서 유저 $userId의 used 포인트를 가져오는 중 에러 발생.',
        origin: 'fetchUsedPointsByUserId',
      );
    }
  }

  // update
  @override
  Future<PointModel> updatePoint(PointModel point) async {
    try {
      final pointRef = firestore.collection('points').doc(point.id);

      // 포인트 문서가 존재하는지 확인
      final snapshot = await pointRef.get();
      if (!snapshot.exists) {
        logger.i('updatePoint: pointId ${point.id}에 해당하는 포인트를 찾을 수 없습니다.');
        throw PointNotFoundException(point.id!, origin: 'updatePoint');
      }

      final updatedData = PointMapper.toMap(point);

      await pointRef.update(updatedData);

      logger.i('updatePoint: pointId ${point.id}가 성공적으로 업데이트되었습니다.');

      // 업데이트된 PointModel 반환
      return point;
    } catch (e, stackTrace) {
      // 예외 처리 및 로깅
      logger.e('updatePoint: pointId ${point.id}를 업데이트하는 중 에러 발생.',
          error: e, stackTrace: stackTrace);
      throw PointFirestoreException(
        'pointId ${point.id}를 업데이트하는 중 에러 발생.',
        pointId: point.id,
        origin: 'updatePoint',
      );
    }
  }

  @override
  Future<void> updateToExpiredPoint(String pointId) async {
    try {
      // 해당 포인트 문서 가져오기
      final pointRef = firestore.collection('points').doc(pointId);
      final snapshot = await pointRef.get();

      // 포인트가 존재하지 않을 경우 예외 처리
      if (!snapshot.exists) {
        logger
            .i('updateToExpiredPoint: pointId $pointId에 해당하는 포인트를 찾을 수 없습니다.');
        throw PointNotFoundException(pointId, origin: 'updatePoint');
      }

      // PointModel로 변환
      final point = PointMapper.fromMap(snapshot.data()!, id: snapshot.id);

      // 만료일이 설정되어 있고, 현재 날짜가 만료일 이후인 경우 상태를 EXPIRED로 변경
      if (point.expireDate != null &&
          DateTime.now().isAfter(point.expireDate!)) {
        // 상태 업데이트
        await pointRef.update({'pointType': 'expired'});
        logger.i(
            'updateToExpiredPoint: pointId $pointId가 EXPIRED 상태로 업데이트되었습니다.');
      }
      // 만료 조건이 아닌 경우, 그대로 반환
      logger.i('updateToExpiredPoint: pointId $pointId는 아직 만료되지 않았습니다.');
    } catch (e, stackTrace) {
      // 에러 발생 시 처리
      logger.e('updateToExpiredPoint: pointId $pointId를 업데이트하는 중 에러 발생.',
          error: e, stackTrace: stackTrace);
      throw PointFirestoreException(
        'pointId $pointId를 업데이트하는 중 에러 발생.',
        pointId: pointId,
        origin: 'updateToExpiredPoint',
      );
    }
  }

  // delete
  @override
  Future<PointModel> deletePoint(String pointId) async {
    try {
      // Firestore에서 해당 포인트 문서 가져오기
      final pointRef = firestore.collection('points').doc(pointId);
      final snapshot = await pointRef.get();

      // 포인트가 존재하지 않으면 예외 처리
      if (!snapshot.exists) {
        logger.i('deletePoint: pointId $pointId에 해당하는 포인트를 찾을 수 없습니다.');
        throw PointNotFoundException(pointId, origin: 'deletePoint');
      }

      // 삭제 전에 PointModel로 변환하여 반환 준비
      final point = PointMapper.fromMap(snapshot.data()!, id: snapshot.id);

      // Firestore에서 문서 삭제
      await pointRef.delete();
      logger.i('deletePoint: pointId $pointId가 성공적으로 삭제되었습니다.');

      // 삭제된 PointModel 반환
      return point;
    } catch (e, stackTrace) {
      // 예외 발생 시 로깅 및 재전달
      logger.e('deletePoint: pointId $pointId를 삭제하는 중 에러 발생.',
          error: e, stackTrace: stackTrace);
      throw PointFirestoreException(
        'pointId $pointId를 삭제하는 중 에러 발생.',
        pointId: pointId,
        origin: 'deletePoint',
      );
    }
  }
}

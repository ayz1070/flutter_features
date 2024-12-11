import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/point_model.dart';
import '../../domain/entities/point_entity.dart';
import '../../domain/entities/point_type.dart';

class PointMapper {
  // Firestore 데이터를 PointModel로 변환
  static PointModel fromMap(Map<String, dynamic> map, {String? id}) {
    return PointModel(
      id: id ?? map['id'] as String?,
      userId: map['userId'] as String,
      reviewId: map['reviewId'] as String?,
      pointPrice: (map['pointPrice'] as num).toDouble(),
      pointType: PointType.values.firstWhere(
            (type) => type.name == map['pointType'],
        orElse: () => throw ArgumentError('Invalid PointType: ${map['pointType']}'),
      ),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      usedAt: map['usedAt'] != null ? (map['usedAt'] as Timestamp).toDate() : null,
      expireDate: map['expireDate'] != null ? (map['expireDate'] as Timestamp).toDate() : null,
    );
  }

  // PointModel을 Firestore 저장용 Map으로 변환
  static Map<String, dynamic> toMap(PointModel point) {
    return {
      'id': point.id,
      'userId': point.userId,
      'reviewId': point.reviewId,
      'pointPrice': point.pointPrice,
      'pointType': point.pointType.name, // Enum을 문자열로 저장
      'createdAt': point.createdAt,
      'usedAt': point.usedAt, // null일 경우 Firestore에서 처리
      'expireDate': point.expireDate, // null일 경우 Firestore에서 처리
    };
  }

  // PointModel을 도메인 엔티티(Point)로 변환
  static PointEntity toEntity(PointModel model) {
    return PointEntity(
      id: model.id,
      userId: model.userId,
      reviewId: model.reviewId,
      pointPrice: model.pointPrice,
      pointType: model.pointType,
      createdAt: model.createdAt,
      usedAt: model.usedAt,
      expireDate: model.expireDate,
    );
  }

  // 도메인 엔티티(Point)를 PointModel로 변환
  static PointModel toModel(PointEntity entity) {
    return PointModel(
      id: entity.id,
      userId: entity.userId,
      reviewId: entity.reviewId,
      pointPrice: entity.pointPrice,
      pointType: entity.pointType,
      createdAt: entity.createdAt,
      usedAt: entity.usedAt,
      expireDate: entity.expireDate,
    );
  }
}

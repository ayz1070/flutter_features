
import '../../domain/entities/point_entity.dart';
import '../../domain/entities/point_type.dart';

class PointViewModel {
  final String id;
  final String userId;
  final String? paymentId;
  final String? reviewId;
  final String title;
  final DateTime createdAt;
  final double pointPrice;
  final bool isEarned;

  PointViewModel({
    required this.id,
    required this.userId,
    this.paymentId,
    this.reviewId,
    required this.title,
    required this.createdAt,
    required this.pointPrice,
    required this.isEarned,
  });

  factory PointViewModel.fromEntity(PointEntity entity) {
    return PointViewModel(
      id: entity.id ?? '',
      userId: entity.userId,
      paymentId: entity.paymentId,
      reviewId: entity.reviewId,
      title: "[${mapPointTypeToString(entity.pointType)}] [COSETIC PB] 촉촉한 앰플 (PointViewModel fromEntity 수정)",
      createdAt: entity.createdAt,
      pointPrice: entity.pointPrice,
      isEarned: entity.pointType == PointType.EARNED,
    );
  }

  PointEntity toEntity() {
    return PointEntity(
      id: id,
      userId: userId,
      paymentId: paymentId,
      reviewId: reviewId,
      pointPrice: pointPrice,
      pointType: isEarned ? PointType.EARNED : PointType.USED,
      createdAt: createdAt,
    );
  }

  static String mapPointTypeToString(PointType type) {
    switch (type) {
      case (PointType.EARNED) :
        return '적립';
      case PointType.USED:
        return '차감';
      case PointType.EXPIRED:
        return '만료';
    }
  }
}

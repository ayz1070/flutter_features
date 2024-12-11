import 'package:flutter_features/features/point/domain/entities/point_type.dart';

class PointEntity {
  final String? id;
  final String userId;
  final String? paymentId;
  final String? reviewId;
  final double pointPrice;
  final PointType pointType;
  final DateTime createdAt;
  final DateTime? usedAt;
  final DateTime expireDate;

  PointEntity({
    this.id,
    required this.userId,
    this.paymentId,
    this.reviewId,
    required this.pointPrice,
    required this.pointType,
    required this.createdAt,
    this.usedAt,
    DateTime? expireDate,
  }) : expireDate = expireDate ?? createdAt.add(Duration(days: 30));

  PointEntity copyWith({
    String? id,
    String? userId,
    String? paymentId,
    String? reviewId,
    double? pointPrice,
    PointType? pointType,
    DateTime? createdAt,
    DateTime? usedAt,
    DateTime? expireDate,
  }) {
    return PointEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      paymentId: paymentId ?? this.paymentId,
      reviewId: reviewId ?? this.reviewId,
      pointPrice: pointPrice ?? this.pointPrice,
      pointType: pointType ?? this.pointType,
      createdAt: createdAt ?? this.createdAt,
      usedAt: usedAt ?? this.usedAt,
      expireDate: expireDate ?? this.expireDate,
    );
  }

}

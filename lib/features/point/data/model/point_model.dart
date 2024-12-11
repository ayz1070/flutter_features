
import '../../domain/entities/point_type.dart';

class PointModel {
  final String? id;
  final String userId;
  final String? paymentId;
  final String? reviewId;
  final double pointPrice;
  final PointType pointType;
  final DateTime createdAt;
  final DateTime? usedAt;
  final DateTime expireDate;

  PointModel({
    this.id,
    required this.userId,
    this.paymentId,
    this.reviewId,
    required this.pointPrice,
    required this.pointType,
    required this.createdAt,
    this.usedAt,
    DateTime? expireDate,
  }) : expireDate = expireDate ?? createdAt.add(Duration(days: 365));
  // 만료일은 생성 시간으로부터 30일

  PointModel copyWith({
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
    return PointModel(
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




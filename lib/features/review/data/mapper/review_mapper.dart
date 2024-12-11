import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/review.dart';
import '../model/review_model.dart';

class ReviewMapper {
  // Firestore에서 가져온 데이터를 ReviewModel로 변환
  static ReviewModel fromMap(Map<String, dynamic> map) {
    if (map['reviewId'] == null) {
      throw Exception("ReviewMapper: 'reviewId' 필드가 누락되었습니다.");
    }
    if (map['userId'] == null) {
      throw Exception("ReviewMapper: 'userId' 필드가 누락되었습니다.");
    }
    if (map['productId'] == null) {
      throw Exception("ReviewMapper: 'productId' 필드가 누락되었습니다.");
    }

    return ReviewModel(
      reviewId: map['reviewId'] as String,
      userId: map['userId'] as String,
      productId: map['productId'] as String,
      rating: (map['rating']?.toDouble() ?? 0.0),
      content: map['content'] ?? '',
      createdAt: (map['createdAt'] is Timestamp)
          ? (map['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
      updatedAt: (map['updatedAt'] is Timestamp)
          ? (map['updatedAt'] as Timestamp).toDate()
          : DateTime.now(),
      imageUrls: (map['imageUrls'] is List) ? List<String>.from(map['imageUrls']) : [],
    );
  }

  // ReviewModel을 Firestore에 저장할 수 있는 Map<String, dynamic>으로 변환
  static Map<String, dynamic> toMap(ReviewModel review) {
    return {
      'reviewId': review.reviewId,
      'userId': review.userId,
      'productId': review.productId,
      'rating': review.rating,
      'content': review.content,
      'createdAt': Timestamp.fromDate(review.createdAt),
      'updatedAt': Timestamp.fromDate(review.updatedAt),
      'imageUrls': review.imageUrls,
    };
  }

  // Review 엔티티를 ReviewModel로 변환
  static ReviewModel fromEntity(Review entity) {
    return ReviewModel(
      reviewId: entity.reviewId,
      userId: entity.userId,
      productId: entity.productId,
      rating: entity.rating,
      content: entity.content,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      imageUrls: entity.imageUrls,
    );
  }

  // ReviewModel을 Review 엔티티로 변환
  static Review toEntity(ReviewModel review) {
    return Review(
      reviewId: review.reviewId,
      userId: review.userId,
      productId: review.productId,
      rating: review.rating,
      content: review.content,
      createdAt: review.createdAt,
      updatedAt: review.updatedAt,
      imageUrls: review.imageUrls,
    );
  }
}
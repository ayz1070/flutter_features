import 'package:equatable/equatable.dart';
import '../../domain/entities/review.dart';

abstract class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object?> get props => [];
}

class FetchPurchasedProductDetailsEvent extends ReviewEvent {
  final String userId;

  const FetchPurchasedProductDetailsEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

// 새로운 리뷰 추가 이벤트
class AddNewReviewEvent extends ReviewEvent {
  final Review newReview;

  const AddNewReviewEvent(this.newReview);

  @override
  List<Object?> get props => [newReview];
}

// 리뷰 업데이트 이벤트
class UpdateReviewEvent extends ReviewEvent {
  final Review updatedReview;

  const UpdateReviewEvent(this.updatedReview);

  @override
  List<Object?> get props => [updatedReview];
}

class DeleteReviewEvent extends ReviewEvent {
  final String reviewId;
  const DeleteReviewEvent(this.reviewId);

  @override
  List<Object?> get props => [reviewId];
}

class FetchReviewsEvent extends ReviewEvent {
  final String userId;

  const FetchReviewsEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}
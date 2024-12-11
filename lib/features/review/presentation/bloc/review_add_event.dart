import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/entities/review.dart';

abstract class ReviewAddEvent extends Equatable {
  const ReviewAddEvent();

  @override
  List<Object?> get props => [];
}

// 리뷰 초기화
class LoadReviewForEdit extends ReviewAddEvent {
  final Review? review;

  const LoadReviewForEdit(this.review);

  @override
  List<Object?> get props => [review];
}

// 별점 변경
class StarRatingChanged extends ReviewAddEvent {
  final double rating;

  const StarRatingChanged(this.rating);

  @override
  List<Object> get props => [rating];
}

// 텍스트 변경
class ReviewTextChanged extends ReviewAddEvent {
  final String text;

  const ReviewTextChanged(this.text);

  @override
  List<Object> get props => [text];
}

// 이미지 추가
class AddImage extends ReviewAddEvent {
  final XFile image;

  const AddImage(this.image);

  @override
  List<Object> get props => [image];
}

// 이미지 삭제
class RemoveImage extends ReviewAddEvent {
  final XFile image;

  const RemoveImage(this.image);

  @override
  List<Object> get props => [image];
}

// 리뷰 제출
class SubmitReview extends ReviewAddEvent {
  final String userId;
  final String productId;
  final double starRating;
  final String reviewText;
  final List<XFile> attachedImages;

  const SubmitReview({
    required this.userId,
    required this.productId,
    required this.starRating,
    required this.reviewText,
    required this.attachedImages,
  });

  @override
  List<Object> get props => [userId, productId, starRating, reviewText, attachedImages];
}

class UpdateReview extends ReviewAddEvent {
  final String reviewId;
  final String userId;
  final String productId;
  final double starRating;
  final String reviewText;
  final List<XFile> attachedImages;

  const UpdateReview({
    required this.reviewId,
    required this.userId,
    required this.productId,
    required this.starRating,
    required this.reviewText,
    required this.attachedImages,
  });

  @override
  List<Object> get props => [reviewId, userId, productId, starRating, reviewText, attachedImages];
}


import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class ReviewAddState extends Equatable {
  const ReviewAddState();

  @override
  List<Object?> get props => [];
}

// 초기 상태
class ReviewAddInitial extends ReviewAddState {
  const ReviewAddInitial();

  @override
  List<Object?> get props => [];
}

// 로딩 상태
class ReviewAddLoading extends ReviewAddState {
  const ReviewAddLoading();

  @override
  List<Object?> get props => [];
}

// 리뷰 로드 완료 상태 (작성 중)
class ReviewAddLoaded extends ReviewAddState {
  final double rating;
  final String reviewText;
  final List<XFile> attachedImages;
  final String successMessage;

  const ReviewAddLoaded({
    required this.rating,
    required this.reviewText,
    required this.attachedImages,
    this.successMessage = '작업이 성공적으로 완료되었습니다.',
  });

  // copyWith 메서드 추가
  ReviewAddLoaded copyWith({
    double? rating,
    String? reviewText,
    List<XFile>? attachedImages,
    String? successMessage,
  }) {
    return ReviewAddLoaded(
      rating: rating ?? this.rating,
      reviewText: reviewText ?? this.reviewText,
      attachedImages: attachedImages ?? this.attachedImages,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  @override
  List<Object> get props => [rating, reviewText, attachedImages, successMessage];
}

// 리뷰 작성 완료 상태
class ReviewAdded extends ReviewAddState {
  final String successMessage;

  const ReviewAdded(this.successMessage);

  @override
  List<Object> get props => [successMessage];
}

class ReviewUpdated extends ReviewAddState{
  final String successMessage;

  const ReviewUpdated(this.successMessage);

  @override
  List<Object> get props => [successMessage];
}


// 에러 상태
class ReviewAddError extends ReviewAddState {
  final String message;

  const ReviewAddError(this.message);

  @override
  List<Object> get props => [message];
}
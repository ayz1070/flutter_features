import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/review.dart';
import '../../domain/usecases/review_use_case.dart';
import 'review_add_event.dart';
import 'review_add_state.dart';
import 'dart:developer' as developer;


class ReviewAddBloc extends Bloc<ReviewAddEvent, ReviewAddState> {
  final SaveReviewUseCase saveReviewUseCase;
  final UpdateReviewUseCase updateReviewUseCase;
  final DeleteReviewUseCase deleteReviewUseCase;
  final Uuid _uuid = Uuid();

  ReviewAddBloc({
    required this.saveReviewUseCase,
    required this.updateReviewUseCase,
    required this.deleteReviewUseCase,
  }) : super(const ReviewAddInitial()) {
    // 리뷰 초기화 이벤트
    on<LoadReviewForEdit>((event, emit) {
      emit(ReviewAddLoading());
      if (event.review != null) {
        emit(
          ReviewAddLoaded(
            rating: event.review!.rating,
            reviewText: event.review!.content ?? '',
            attachedImages:
            event.review!.imageUrls.map((url) => XFile(url)).toList(),
          ),
        );
      } else {
        emit(const ReviewAddLoaded(
            rating: 0.0, reviewText: '', attachedImages: []));
      }
    });

    // 별점 변경 이벤트
    on<StarRatingChanged>((event, emit) {
      if (state is ReviewAddLoaded) {
        final currentState = state as ReviewAddLoaded;
        emit(currentState.copyWith(rating: event.rating));
      }
    });

    // 리뷰 텍스트 변경 이벤트
    on<ReviewTextChanged>((event, emit) {
      if (state is ReviewAddLoaded) {
        final currentState = state as ReviewAddLoaded;
        emit(currentState.copyWith(reviewText: event.text));
      }
    });

    // 이미지 추가 이벤트
    on<AddImage>((event, emit) {
      if (state is ReviewAddLoaded) {
        final currentState = state as ReviewAddLoaded;
        final updatedImages = List<XFile>.from(currentState.attachedImages)
          ..add(event.image);
        emit(currentState.copyWith(attachedImages: updatedImages));
      }
    });

    // 이미지 삭제 이벤트
    on<RemoveImage>((event, emit) {
      if (state is ReviewAddLoaded) {
        final currentState = state as ReviewAddLoaded;
        final updatedImages = List<XFile>.from(currentState.attachedImages)
          ..remove(event.image);
        emit(currentState.copyWith(attachedImages: updatedImages));
      }
    });

    // 리뷰 제출 이벤트
    on<SubmitReview>((event, emit) async {
      try {
        final currentState = state as ReviewAddLoaded;
        final review = Review(
          reviewId: _generateReviewId(),
          userId: event.userId,
          productId: event.productId,
          rating: currentState.rating,
          content: currentState.reviewText,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          imageUrls: currentState.attachedImages.map((image) => image.path).toList(),
        );
        await saveReviewUseCase.call(review);
        emit(const ReviewAdded("리뷰가 성공적으로 저장되었습니다."));
        developer.log("ReviewAddBloc: emitting ReviewAdded state");


      } catch (_) {
        emit(const ReviewAddError("리뷰를 저장하는 중 오류가 발생했습니다."));
      }
    });

// 리뷰 업데이트 이벤트
    on<UpdateReview>((event, emit) async {
      try {
        if (state is ReviewAddLoaded) {
          final currentState = state as ReviewAddLoaded;
          final review = Review(
            reviewId: event.reviewId,
            userId: event.userId,
            productId: event.productId,
            rating: currentState.rating,
            content: currentState.reviewText,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            imageUrls: currentState.attachedImages.map((image) => image.path).toList(),
          );
          await updateReviewUseCase.call(review);
          emit(ReviewUpdated("리뷰가 성공적으로 수정되었습니다."));
          //developer.log("ReviewAddBloc: emitting ReviewUpdated state");


        }
      } catch (_) {
        emit(const ReviewAddError("리뷰를 업데이트하는 중 오류가 발생했습니다."));
      }
    });
  }

  String _generateReviewId() {
    return _uuid.v4();
  }
}
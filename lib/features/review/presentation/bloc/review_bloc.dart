import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import '../../domain/usecases/purchased_product_use_case.dart';
import '../../domain/usecases/review_use_case.dart';
import '../vm/product_view_model.dart';
import 'review_event.dart';
import 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final FetchPurchasedProductsWithDetailsUseCase fetchPurchasedProductsUseCase;
  final FetchReviewsByUserUseCase fetchReviewsByUserUseCase;
  final DeleteReviewUseCase deleteReviewUseCase;

  final Logger _logger = Logger();

  ReviewBloc({
    required this.fetchPurchasedProductsUseCase,
    required this.fetchReviewsByUserUseCase,
    required this.deleteReviewUseCase,
  }) : super(ReviewInitial()) {
    on<FetchPurchasedProductDetailsEvent>((event, emit) async {
      if (state is ReviewLoading) return;

      emit(ReviewLoading());
      try {
        final purchasedProductDetails = await fetchPurchasedProductsUseCase(event.userId);
        final userReviews = await fetchReviewsByUserUseCase(event.userId);

        final productInfoList = purchasedProductDetails.map((detail) {
          return ProductViewModel(
            productId: detail["productDetails"].id,
            purchaseDate: detail["purchasedProduct"].purchaseDate,
            productName: detail["productDetails"].name,
            productImageUrl: detail["productDetails"].imageUrl,
          );
        }).toList();

        emit(ReviewLoaded(productInfoList, userReviews));
      } catch (e, stackTrace) {
        _logger.e('Error in FetchPurchasedProductDetailsEvent');
        emit(ReviewError('구매한 상품 데이터를 불러오는데 실패했습니다.'));
      }
    });

    on<AddNewReviewEvent>((event, emit) {
      if (state is ReviewLoaded) {
        final currentState = state as ReviewLoaded;

        try {
          final updatedReviews = List.of(currentState.userReviews)
            ..add(event.newReview);
              emit(ReviewLoaded(currentState.productInfoList, updatedReviews));
        } catch (e, stackTrace) {
          _logger.e('Error in AddNewReviewEvent');
          emit(ReviewError("리뷰 추가 중 오류가 발생했습니다."));
        }
      }
    });

    on<UpdateReviewEvent>((event, emit) {
      if (state is ReviewLoaded) {
        final currentState = state as ReviewLoaded;

        try {
          final updatedReviews = currentState.userReviews.map((review) {
            return review.reviewId == event.updatedReview.reviewId
                ? event.updatedReview
                : review;
          }).toList();

          emit(ReviewLoaded(currentState.productInfoList, updatedReviews)); // 상태 전환
        } catch (e, stackTrace) {
          _logger.e('Error in UpdateReviewEvent');
          emit(ReviewError('리뷰 수정 중 오류가 발생했습니다.'));
        }
      }
    });

    on<DeleteReviewEvent>((event, emit) async {
      if (state is ReviewLoaded) {
        final currentState = state as ReviewLoaded;

        emit(ReviewLoading());

        try {
          await deleteReviewUseCase.call(event.reviewId);

          final updatedReviews = currentState.userReviews
              .where((review) => review.reviewId != event.reviewId)
              .toList();

          emit(ReviewLoaded(currentState.productInfoList, updatedReviews));
        } catch (e, stackTrace) {
          _logger.e('Error in DeleteReviewEvent');
          emit(ReviewError('리뷰 삭제 중 오류가 발생했습니다.'));
        }
      }
    });


  }
}
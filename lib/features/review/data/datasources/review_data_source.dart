import '../model/review_model.dart';

abstract class ReviewDataSource {
  // 리뷰 저장 (Create)
  Future<void> saveReview(ReviewModel review);

  // 리뷰 수정 (Update)
  Future<void> updateReview(ReviewModel review);

  // 리뷰 삭제 (Delete)
  Future<void> deleteReview(String reviewId);

  // 리뷰 불러오기 (Read)
  Future<ReviewModel> fetchReview(String reviewId);

  // 특정 상품에 대한 리뷰 목록 불러오기
  Future<List<ReviewModel>> fetchReviewsByProduct(String productId);

  // 특정 사용자에 대한 리뷰 목록 불러오기
  Future<List<ReviewModel>> fetchReviewsByUser(String userId);
}


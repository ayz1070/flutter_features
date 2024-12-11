import '../../domain/entities/review.dart';

abstract class ReviewRepository {
  Future<void> saveReview(Review review);
  Future<void> updateReview(Review review);
  Future<void> deleteReview(String reviewId);
  Future<Review> fetchReview(String reviewId);
  Future<List<Review>> fetchReviewsByProduct(String productId);
  Future<List<Review>> fetchReviewsByUser(String userId);
}
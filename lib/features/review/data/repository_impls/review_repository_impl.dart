import '../../domain/entities/review.dart';
import '../../domain/repositories/review_repository.dart';
import '../datasources/review_data_source.dart';
import '../mapper/review_mapper.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewDataSource remoteDataSource;

  ReviewRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> saveReview(Review review) async {
    try {
      final reviewModel = ReviewMapper.fromEntity(review);
      await remoteDataSource.saveReview(reviewModel);
    } catch (e) {
      print("ReviewRepositoryImpl: 리뷰 저장 실패 - $e");
      rethrow;
    }
  }

  @override
  Future<void> updateReview(Review review) async {
    try {
      final reviewModel = ReviewMapper.fromEntity(review);
      await remoteDataSource.updateReview(reviewModel);
    } catch (e) {
      print("ReviewRepositoryImpl: 리뷰 업데이트 실패 - $e");
      rethrow;
    }
  }

  @override
  Future<void> deleteReview(String reviewId) async {
    try {
      await remoteDataSource.deleteReview(reviewId);
    } catch (e) {
      print("ReviewRepositoryImpl: 리뷰 삭제 실패 - $e");
      rethrow;
    }
  }

  @override
  Future<Review> fetchReview(String reviewId) async {
    try {
      final reviewModel = await remoteDataSource.fetchReview(reviewId);
      return ReviewMapper.toEntity(reviewModel);
    } catch (e) {
      print("ReviewRepositoryImpl: 리뷰 가져오기 실패 - $e");
      rethrow;
    }
  }

  @override
  Future<List<Review>> fetchReviewsByProduct(String productId) async {
    try {
      final reviewModels = await remoteDataSource.fetchReviewsByProduct(productId);
      return reviewModels.map((model) => ReviewMapper.toEntity(model)).toList();
    } catch (e) {
      print("ReviewRepositoryImpl: 리뷰 by product 가져오기 실패- $e");
      rethrow;
    }
  }

  @override
  Future<List<Review>> fetchReviewsByUser(String userId) async {
    try {
      final reviewModels = await remoteDataSource.fetchReviewsByUser(userId);
      return reviewModels.map((model) => ReviewMapper.toEntity(model)).toList();
    } catch (e) {
      print("ReviewRepositoryImpl: 리뷰 by user 가져오기 실패 - $e");
      rethrow;
    }
  }
}
import '../../../../core/exceptions/review_exception.dart';
import '../entities/review.dart';
import '../repositories/review_repository.dart';


class ReviewUseCases {
  final ReviewRepository repository;

  ReviewUseCases({required this.repository});

  late final SaveReviewUseCase saveReviewUseCase = SaveReviewUseCase(repository: repository);
  late final UpdateReviewUseCase updateReviewUseCase = UpdateReviewUseCase(repository: repository);
  late final DeleteReviewUseCase deleteReviewUseCase = DeleteReviewUseCase(repository: repository);
  late final FetchReviewUseCase fetchReviewUseCase = FetchReviewUseCase(repository: repository);
  late final FetchReviewsByProductUseCase fetchReviewsByProductUseCase = FetchReviewsByProductUseCase(repository: repository);
  late final FetchReviewsByUserUseCase fetchReviewsByUserUseCase = FetchReviewsByUserUseCase(repository: repository);
}

abstract class ReviewUseCase<Type, Params> {
  Future<Type> call(Params params);
}

class SaveReviewUseCase extends ReviewUseCase<void, Review> {
  final ReviewRepository repository;

  SaveReviewUseCase({required this.repository});

  @override
  Future<void> call(Review review) async {
    try {
      await repository.saveReview(review);
    } catch (e) {
      throw ReviewException('Error saving review', e);
    }
  }
}

class UpdateReviewUseCase extends ReviewUseCase<void, Review> {
  final ReviewRepository repository;

  UpdateReviewUseCase({required this.repository});

  @override
  Future<void> call(Review review) async {
    try {
      await repository.updateReview(review);
    } catch (e) {
      throw ReviewException('Error updating review', e);
    }
  }
}

class DeleteReviewUseCase extends ReviewUseCase<void, String> {
  final ReviewRepository repository;

  DeleteReviewUseCase({required this.repository});

  @override
  Future<void> call(String reviewId) async {
    try {
      await repository.deleteReview(reviewId);
    } catch (e) {
      throw ReviewException('Error deleting review with ID $reviewId', e);
    }
  }
}

class FetchReviewUseCase extends ReviewUseCase<Review, String> {
  final ReviewRepository repository;

  FetchReviewUseCase({required this.repository});

  @override
  Future<Review> call(String reviewId) async {
    try {
      return await repository.fetchReview(reviewId);
    } catch (e) {
      throw ReviewException('Error fetching review with ID $reviewId', e);
    }
  }
}

class FetchReviewsByProductUseCase extends ReviewUseCase<List<Review>, String> {
  final ReviewRepository repository;

  FetchReviewsByProductUseCase({required this.repository});

  @override
  Future<List<Review>> call(String productId) async {
    try {
      return await repository.fetchReviewsByProduct(productId);
    } catch (e) {
      throw ReviewException('Error fetching reviews for product ID $productId', e);
    }
  }
}

class FetchReviewsByUserUseCase extends ReviewUseCase<List<Review>, String> {
  final ReviewRepository repository;

  FetchReviewsByUserUseCase({required this.repository});

  @override
  Future<List<Review>> call(String userId) async {
    try {
      return await repository.fetchReviewsByUser(userId);
    } catch (e) {
      throw ReviewException('Error fetching reviews for user ID $userId', e);
    }
  }
}
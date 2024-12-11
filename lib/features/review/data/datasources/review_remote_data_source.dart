import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_features/features/review/data/datasources/review_data_source.dart';
import '../../../../core/constants/firestore_collections.dart';
import '../model/review_model.dart';
import '../mapper/review_mapper.dart';

class ReviewRemoteDataSource implements ReviewDataSource {
  final FirebaseFirestore firestore;

  ReviewRemoteDataSource({required this.firestore});

  // 리뷰 저장 (Create)
  @override
  Future<void> saveReview(ReviewModel review) async {
    try {
      await firestore.runTransaction((transaction) async {
        // 리뷰를 메인 리뷰 컬렉션에 저장
        final reviewRef = firestore
            .collection(FirestoreCollections.reviewsCollection)
            .doc(review.reviewId);
        transaction.set(reviewRef, ReviewMapper.toMap(review));

        // 유저의 리뷰 하위 컬렉션에 저장
        final userReviewRef = firestore
            .collection("users")
            .doc(review.userId)
            .collection('reviews')
            .doc(review.reviewId);
        transaction.set(userReviewRef, ReviewMapper.toMap(review));

        // await Future.delayed(Duration(seconds: 3));
        // 상품의 리뷰 하위 컬렉션에 저장
        final productReviewRef = firestore
            .collection('products')
            .doc('test_product_id') // 필요한 경우 review.productId를 사용
            .collection('reviews')
            .doc(review.reviewId);
        transaction.set(productReviewRef, ReviewMapper.toMap(review));
      });

      // 트랜잭션 성공
      print('리뷰가 성공적으로 저장되었습니다.');
    } on FirebaseException catch (e) {
      throw Exception('리뷰 저장 실패 (Firebase): ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('리뷰 저장 실패: $e');
    }
  }

  // 리뷰 수정 (Update)
  @override
  Future<void> updateReview(ReviewModel review) async {
    try {
      await firestore
          .collection(FirestoreCollections.reviewsCollection)
          .doc(review.reviewId)
          .update(ReviewMapper.toMap(review));
    } on FirebaseException catch (e) {
      throw Exception('리뷰 수정 실패 (Firebase): ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('리뷰 수정 실패: $e');
    }
  }

  // 리뷰 삭제 (Delete)
  @override
  Future<void> deleteReview(String reviewId) async {
    try {
      await firestore
          .collection(FirestoreCollections.reviewsCollection)
          .doc(reviewId)
          .delete();
    } on FirebaseException catch (e) {
      throw Exception('리뷰 삭제 실패 (Firebase): ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('리뷰 삭제 실패: $e');
    }
  }

  // 리뷰 불러오기 (Read)
  @override
  Future<ReviewModel> fetchReview(String reviewId) async {
    try {
      final doc = await firestore
          .collection(FirestoreCollections.reviewsCollection)
          .doc(reviewId)
          .get();
      if (doc.exists) {
        return ReviewMapper.fromMap(doc.data() as Map<String, dynamic>);
      } else {
        throw Exception('해당 리뷰가 없음');
      }
    } catch (e) {
      throw Exception('리뷰 가져오기 실패: $e');
    }
  }

  // 특정 상품에 대한 리뷰 목록 불러오기
  @override
  Future<List<ReviewModel>> fetchReviewsByProduct(String productId) async {
    try {
      final querySnapshot = await firestore
          .collection(FirestoreCollections.reviewsCollection)
          .where('productId', isEqualTo: productId)
          .get();
      return querySnapshot.docs
          .map((doc) => ReviewMapper.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('상품명으로 리뷰 가져오기 실패: $e');
    }
  }

  // 특정 사용자에 대한 리뷰 목록 불러오기
  @override
  Future<List<ReviewModel>> fetchReviewsByUser(String userId) async {
    try {
      final querySnapshot = await firestore
          .collection(FirestoreCollections.reviewsCollection)
          .where('userId', isEqualTo: userId)
          .get();
      return querySnapshot.docs
          .map((doc) => ReviewMapper.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('사용자로 리뷰 가져오기 실패: $e');
    }
  }
}
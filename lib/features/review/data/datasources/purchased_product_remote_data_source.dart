import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_features/features/review/data/datasources/purchased_product_data_source.dart';
import '../../../../core/constants/firestore_collections.dart';
import '../model/purchased_product_model.dart';
import '../mapper/purchased_product_mapper.dart';

class PurchasedProductRemoteDataSource implements PurchasedProductDataSource {
  final FirebaseFirestore firestore;

  PurchasedProductRemoteDataSource({required this.firestore});

  Future<List<PurchasedProductModel>> fetchPurchasedProductsByUser(String userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection(FirestoreCollections.purchasedProductsCollection)
          .where('userId', isEqualTo: userId)
          .get();

      if (snapshot.docs.isEmpty) {
        print("PurchasedProductRemoteDataSource: userId $userId 에 해당하는 구매한 상품이 없습니다.");
        return [];
      }

      List<PurchasedProductModel> data = snapshot.docs.map((doc) {
        return PurchasedProductMapper.fromMap(doc.data(), doc.id);
      }).toList();

      print("PurchasedProductRemoteDataSource: 변환된 데이터 - $data");
      return data;

    } on FirebaseException catch (e) {
      print("FirebaseException 발생: ${e.code} - ${e.message}");
      throw Exception("Firestore 관련 예외 발생: ${e.message}");
    } catch (e) {
      print("기타 Exception 발생: $e");
      throw Exception("PurchasedProductRemoteDataSource: 구매한 상품을 불러오는 중 알 수 없는 오류 발생. $e");
    }
  }
}
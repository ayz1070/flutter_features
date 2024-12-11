import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/constants/firestore_collections.dart';
import '../model/product_model.dart';
import '../mapper/product_mapper.dart';
import 'product_data_source.dart';

class ProductRemoteDataSource implements ProductDataSource {
  final FirebaseFirestore firestore;

  ProductRemoteDataSource({required this.firestore});

  @override
  Future<List<ProductModel>> fetchProductsByIds(List<String> productIds) async {
    try {
      if (productIds.isEmpty) {
        print("ProductRemoteDataSource: productIds 리스트가 비어 있습니다.");
        return [];
      }

      if (productIds.length > 10) {
        print("ProductRemoteDataSource: productIds의 항목이 10개를 초과하여 Firestore 쿼리에서 제한에 걸릴 수 있습니다.");
        productIds = productIds.sublist(0, 10);
      }

      QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection(FirestoreCollections.productsCollection)
          .where(FieldPath.documentId, whereIn: productIds)
          .get();

      print("ProductRemoteDataSource: snapshot 길이: ${snapshot.docs.length}");

      // 비동기 변환 처리를 위해 Future 리스트를 생성하고, 완료된 결과를 반환
      List<Future<ProductModel>> futures = snapshot.docs.map((doc) {
        return ProductMapper.fromMap(doc.data(), doc.id);
      }).toList();

      return await Future.wait(futures);

    } on FirebaseException catch (e) {
      throw Exception("ProductRemoteDataSource: Firestore 예외가 발생했습니다. ${e.code} : ${e.message}");
    } catch (e) {
      throw Exception("ProductRemoteDataSource: 상품 데이터를 불러오는 중 알 수 없는 예외가 발생했습니다. $e");
    }
  }
}
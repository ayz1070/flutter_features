import 'package:firebase_storage/firebase_storage.dart';
import '../model/product_model.dart';

class ProductMapper {
  static Future<ProductModel> fromMap(Map<String, dynamic> json, String id) async {
    String downloadUrl;
    try {
      final storageRef = FirebaseStorage.instance.ref(json['imageUrl']);
      downloadUrl = await storageRef.getDownloadURL();
    } catch (e) {
      print("ProductMapper: 이미지 URL 가져오기 실패 - $e");
      downloadUrl = ''; // 기본값 또는 오류 발생 시의 처리 로직
    }

    return ProductModel(
      id: id,
      name: json['name'] as String,
      brand: json['brand'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      imageUrl: downloadUrl, // Storage에서 가져온 다운로드 URL을 사용
      price: json['price'] as int,
      discountPrice: json['discountPrice'] as int,
      discountRate: json['discountRate'] as int,
      expirationDate: json['expirationDate'] as String,
      caution: json['caution'] as String,
      delivery: json['delivery'] as String,
      ingredients: json['ingredients'] as String,
      qna: json['qna'] as String,
      review: json['review'] as String,
      specificationType: json['specificationType'] as String,
      userId: json['userId'] as String,
      volume: json['volume'] as String,
      whetherAudit: json['whetherAudit'] as String,
    );
  }

  static Map<String, dynamic> toMap(ProductModel model) {
    return {
      'name': model.name,
      'brand': model.brand,
      'category': model.category,
      'description': model.description,
      'imageUrl': model.imageUrl, // Storage의 경로를 저장
      'price': model.price,
      'discountPrice': model.discountPrice,
      'discountRate': model.discountRate,
      'expirationDate': model.expirationDate,
      'caution': model.caution,
      'delivery': model.delivery,
      'ingredients': model.ingredients,
      'qna': model.qna,
      'review': model.review,
      'specificationType': model.specificationType,
      'userId': model.userId,
      'volume': model.volume,
      'whetherAudit': model.whetherAudit,
    };
  }
}
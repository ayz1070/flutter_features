import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/purchased_product_model.dart';
import '../../domain/entities/purchased_product.dart';

class PurchasedProductMapper {
  // Firestore에서 가져온 데이터를 PurchasedProductModel로 변환
  static PurchasedProductModel fromMap(Map<String, dynamic> json, String id) {
    try {
      // 필수 필드 검증
      final productId = json['productId'] as String?;
      final userId = json['userId'] as String?;
      final purchaseDate = (json['purchaseDate'] as Timestamp?)?.toDate();
      final quantity = json['quantity'] as int?;
      final purchasePrice = (json['purchasePrice'] as num?)?.toInt();
      final isReviewed = json['isReviewed'] as bool?;

      // 필드 유효성 검증
      if (productId == null || userId == null) {
        throw Exception("productId 또는 userId 필드가 null입니다.");
      }
      if (purchaseDate == null) {
        throw Exception("purchaseDate 필드가 null이거나 Timestamp가 아닙니다.");
      }
      if (quantity == null || purchasePrice == null) {
        throw Exception("quantity 또는 purchasePrice 필드가 null이거나 타입이 맞지 않습니다.");
      }
      if (isReviewed == null) {
        throw Exception("isReviewed 필드가 null입니다.");
      }

      return PurchasedProductModel(
        id: id,
        productId: productId,
        userId: userId,
        purchaseDate: purchaseDate,
        quantity: quantity,
        purchasePrice: purchasePrice,
        isReviewed: isReviewed,
      );
    } catch (e) {
      print("PurchasedProductMapper : 매핑 오류 - $e");
      rethrow;
    }
  }

  // PurchasedProductModel을 Firestore에 저장할 수 있는 Map<String, dynamic>으로 변환
  static Map<String, dynamic> toMap(PurchasedProductModel model) {
    return {
      'productId': model.productId,
      'userId': model.userId,
      'purchaseDate': Timestamp.fromDate(model.purchaseDate),
      'quantity': model.quantity,
      'purchasePrice': model.purchasePrice,
      'isReviewed': model.isReviewed,
    };
  }

  // PurchasedProduct 엔티티를 PurchasedProductModel로 변환
  static PurchasedProductModel fromEntity(PurchasedProduct entity) {
    return PurchasedProductModel(
      id: entity.id,
      productId: entity.productId,
      userId: entity.userId,
      purchaseDate: entity.purchaseDate,
      quantity: entity.quantity,
      purchasePrice: entity.purchasePrice,
      isReviewed: entity.isReviewed,
    );
  }

  // PurchasedProductModel을 PurchasedProduct 엔티티로 변환
  static PurchasedProduct toEntity(PurchasedProductModel model) {
    return PurchasedProduct(
      id: model.id,
      productId: model.productId,
      userId: model.userId,
      purchaseDate: model.purchaseDate,
      quantity: model.quantity,
      purchasePrice: model.purchasePrice,
      isReviewed: model.isReviewed,
    );
  }
}
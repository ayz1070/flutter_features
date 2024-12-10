import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/cart_product.dart';
import '../model/cart_product_model.dart';

class CartProductMapper {
  // Firestore 데이터를 CartProductModel로 변환
  static CartProductModel fromMap(Map<String, dynamic> data, {String? id}) {
    try {
      return CartProductModel(
        id: id ?? (data['id'] as String? ?? ''), // ID가 없으면 빈 문자열로 처리
        productId: data['productId'] as String? ?? '', // productId가 없으면 빈 문자열
        cartId: data['cartId'] as String? ?? '', // cartId가 없으면 빈 문자열
        quantity: data['quantity'] as int? ?? 0, // quantity가 없으면 0
        createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(), // createdAt이 없거나 null이면 현재 시간
        isChecked: data['isChecked'] as bool? ?? true,
      );
    } catch (e) {
      print("CartProductMapper.fromMap -> Error parsing data: $data");
      throw Exception("Failed to map Firestore data to CartProductModel: $e");
    }
  }

  // Firestore 문서 스냅샷을 CartProductModel로 변환
  static CartProductModel fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data();

    if (data == null) {
      print("CartProductMapper.fromSnapshot -> Error: Snapshot data is null for ID: ${snapshot.id}");
      throw Exception("Snapshot data is null for ID: ${snapshot.id}");
    }

    if (data is! Map<String, dynamic>) {
      print("CartProductMapper.fromSnapshot -> Error: Unexpected data type: ${data.runtimeType} for ID: ${snapshot.id}");
      throw Exception("Unexpected data type: ${data.runtimeType} for ID: ${snapshot.id}");
    }

    print("CartProductMapper.fromSnapshot -> Snapshot data for ID: ${snapshot.id}: $data");
    return fromMap(data, id: snapshot.id);
  }

  // CartProductModel을 Firestore 데이터로 변환
  static Map<String, dynamic> toMap(CartProductModel cartProduct) {
    return {
      'id': cartProduct.id,
      'productId': cartProduct.productId,
      'cartId': cartProduct.cartId,
      'quantity': cartProduct.quantity,
      'createdAt': cartProduct.createdAt,
      'isChecked': cartProduct.isChecked,
    };
  }

  // CartProductModel을 엔티티로 변환
  static CartProduct toEntity(CartProductModel cartProductModel) {
    return CartProduct(
      id: cartProductModel.id,
      productId: cartProductModel.productId,
      cartId: cartProductModel.cartId,
      quantity: cartProductModel.quantity,
      createdAt: cartProductModel.createdAt,
      isChecked: cartProductModel.isChecked,
    );
  }

  // 엔티티를 CartProductModel로 변환
  static CartProductModel toModel(CartProduct cartProduct) {
    return CartProductModel(
      id: cartProduct.id,
      productId: cartProduct.productId,
      cartId: cartProduct.cartId,
      quantity: cartProduct.quantity,
      createdAt: cartProduct.createdAt,
      isChecked: cartProduct.isChecked,
    );
  }
}

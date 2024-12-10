import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/cart.dart';
import '../model/cart_model.dart';

class CartMapper {
  // Firestore 데이터를 CartModel로 변환
  static CartModel fromMap(Map<String, dynamic> data, String id) {
    return CartModel(
      id: id,
      userId: data['userId'] as String,
      deliveryPolicyId: data['deliveryPolicyId'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  // CartModel을 Firestore 데이터로 변환
  static Map<String, dynamic> toMap(CartModel cart) {
    return {
      'id' : cart.id,
      'userId': cart.userId,
      'deliveryPolicyId': cart.deliveryPolicyId,
      'createdAt': cart.createdAt,
      'updatedAt': cart.updatedAt,
    };
  }

  // CartModel을 엔티티로 변환
  static Cart toEntity(CartModel cartModel) {
    return Cart(
      id: cartModel.id,
      userId: cartModel.userId,
      deliveryPolicyId: cartModel.deliveryPolicyId,
      createdAt: cartModel.createdAt,
      updatedAt: cartModel.updatedAt,
    );
  }

  // 엔티티를 CartModel로 변환
  static CartModel toModel(Cart cart) {
    return CartModel(
      id: cart.id,
      userId: cart.userId,
      deliveryPolicyId: cart.deliveryPolicyId,
      createdAt: cart.createdAt,
      updatedAt: cart.updatedAt,
    );
  }
}
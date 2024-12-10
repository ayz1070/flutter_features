import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/utils/test_data.dart';
import '../mapper/cart_mapper.dart';
import '../model/cart_model.dart';
import 'cart_data_source.dart';

class CartRemoteDataSource implements CartDataSource {
  final FirebaseFirestore firestore;
  final String userId = TestData.loginedUser.id;

  CartRemoteDataSource({required this.firestore});

  @override
  Future<CartModel> fetchCartById(String cartId) async {
    try {
      print("CartRemoteDataSource : Fetching cart with ID: $cartId");

      final cartDoc = await firestore.collection('carts').doc(cartId).get();

      if (!cartDoc.exists) {
        print("CartRemoteDataSource : Cart with ID $cartId not found");
        throw Exception('Cart not found');
      }

      final cartModel = CartMapper.fromMap(cartDoc.data()!, cartDoc.id);
      print("CartRemoteDataSource : Fetched cart: $cartModel");
      return cartModel;
    } catch (e) {
      print("CartRemoteDataSource : Error fetching cart with ID: $cartId");
      rethrow;
    }
  }

  @override
  Future<CartModel?> fetchCartByUserId() async {
    try {
      print("CartRemoteDataSource : Fetching cart for user ID: $userId");

      final querySnapshot = await firestore
          .collection('carts')
          .where('userId', isEqualTo: userId)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        print("CartRemoteDataSource : No cart found for user ID: $userId");
        return null;
      }

      final cartDoc = querySnapshot.docs.first;
      final cartModel = CartMapper.fromMap(cartDoc.data(), cartDoc.id);
      print("CartRemoteDataSource : Fetched cart for user $userId: $cartModel");
      return cartModel;
    } catch (e) {
      print("CartRemoteDataSource : Error fetching cart for user ID: $userId");
      rethrow;
    }
  }

  @override
  Future<void> saveCart(CartModel cart) async {
    try {
      // Step 1: 기존 장바구니 조회
      // userId로 존재 여부 파악
      final cartQuery = await firestore
          .collection('carts')
          .where('userId', isEqualTo: userId)
          .limit(1) // 하나의 장바구니만 관리한다고 가정
          .get();

      if (cartQuery.docs.isNotEmpty) {
        // Step 2: 기존 장바구니 처리
        final existingCart = cartQuery.docs.first;
        print(
            "Cart already exists for userId: ${userId}, cartId: ${existingCart.id}");

        // 필요 시 기존 장바구니를 업데이트
        final updatedCart = cart.copyWith(id: existingCart.id);
        final cartData = CartMapper.toMap(updatedCart);

        await firestore.collection('carts').doc(existingCart.id).set(cartData);
        print(
            "CartRemoteDataSource : Cart updated for userId: ${cart.userId}, cartId: ${existingCart.id}");
        return;
      }

      // Step 3: 새로운 장바구니 생성 (처음 생성)
      final cartId = cart.id ?? firestore.collection('carts').doc().id;
      final cartRef = firestore.collection('carts').doc(cartId);

      // 필드 id와 문서 id를 동일하게 유지
      final cartData = CartMapper.toMap(cart.copyWith(id: cartId));
      await cartRef.set(cartData);

      print("New cart created for userId: ${cart.userId}, cartId: $cartId");
    } catch (e) {
      print("Error saving cart for userId: ${cart.userId} - $e");
      rethrow;
    }
  }


  @override
  Future<void> deleteCart(String cartId) async {
    try {
      print("CartRemoteDataSource : Deleting cart with ID: $cartId");

      final cartRef = firestore.collection('carts').doc(cartId);

      // Delete all products in the cart
      await _deleteCartProducts(cartRef);

      // Delete the cart itself
      await cartRef.delete();

      print("CartRemoteDataSource : Cart with ID $cartId deleted successfully");
    } catch (e) {
      print("CartRemoteDataSource : Error deleting cart with ID: $cartId");
      rethrow;
    }
  }

  // 장바구니 비우기
  // 조건 : 1. cartId과 일치, 2. isChecked가 true
  @override
  Future<void> clearCart(String cartId) async {
    try {
      print("CartRemoteDataSource : clear cart ID: $cartId");

      final cartRef = firestore.collection('carts').doc(cartId);

      // Step 1: Clear checked products in the cart
      await _deleteCartProducts(cartRef);

      // Step 2: Update the cart's updatedAt field
      await cartRef.update({'updatedAt': FieldValue.serverTimestamp()});

      print("CartRemoteDataSource : Cleared contents of cart with ID: $cartId");
    } catch (e) {
      print("CartRemoteDataSource : Error clearing contents of cart with ID: $cartId - $e");
      rethrow;
    }
  }

  Future<void> _deleteCartProducts(DocumentReference cartRef) async {
    try {
      print("CartRemoteDataSource : delete products from cart ${cartRef.id}");

      // Fetch all checked products associated with the cartId
      final cartProductsQuery = await firestore
          .collection("cart_products")
          .where("cartId", isEqualTo: cartRef.id)
          .where("isChecked", isEqualTo: true)
          .get();

      if (cartProductsQuery.docs.isEmpty) {
        print("CartRemoteDataSource : No checked products found in cart ${cartRef.id}");
        return;
      }

      // Use Firestore batch to delete all checked products
      final batch = firestore.batch();

      for (final doc in cartProductsQuery.docs) {
        batch.delete(doc.reference);
      }

      // Commit the batch
      await batch.commit();
      print("CartRemoteDataSource : All checked products in cart ${cartRef.id} deleted successfully");
    } catch (e) {
      print("CartRemoteDataSource : Error deleting products in cart ${cartRef.id} - $e");
      rethrow;
    }
  }
}

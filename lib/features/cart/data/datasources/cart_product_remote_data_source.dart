import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/utils/test_data.dart';
import '../mapper/cart_mapper.dart';
import '../mapper/cart_product_mapper.dart';
import '../model/cart_model.dart';
import '../model/cart_product_model.dart';
import 'cart_product_data_source.dart';


class CartProductRemoteDataSource implements CartProductDataSource {
  final FirebaseFirestore firestore;
  final String userId = TestData.loginedUser.id;

  CartProductRemoteDataSource({required this.firestore});

  @override
  Future<void> saveCartProduct(CartProductModel cartProduct) async {
    try {
      print(
          "CartProductRemoteDataSource : Saving product for user ID: $userId, product: $cartProduct");

      await firestore.runTransaction((transaction) async {
        // Step 1: userId로 장바구니 조회
        final cartQuery = await firestore
            .collection('carts')
            .where("userId", isEqualTo: userId)
            .limit(1)
            .get();

        String cartId;

        if (cartQuery.docs.isEmpty) {
          // Step 2: 장바구니 생성 (기존 _saveCart 호출)
          print("CartProductRemoteDataSource : 장바구니가 없습니다. 새로운 장바구니를 생성합니다.");

          final newCart = CartModel(
            id: null,
            userId: userId,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            deliveryPolicyId: 'test_delivery_policy_id',
          );

          // 새로운 장바구니 생성
          await _saveCart(newCart);

          // 새로 생성된 장바구니 ID 가져오기
          final newCartQuery = await firestore
              .collection('carts')
              .where("userId", isEqualTo: userId)
              .limit(1)
              .get();

          if (newCartQuery.docs.isEmpty) {
            throw Exception(
                "CartProductRemoteDataSource : 장바구니 생성 후에도 Cart ID를 찾을 수 없습니다.");
          }

          cartId = newCartQuery.docs.first.id;
        } else {
          cartId = cartQuery.docs.first.id;
          print(
              "CartProductRemoteDataSource : Found cart ID: $cartId for user ID: $userId");
        }

        // Step 3: 중복 상품 체크
        final existingProductQuery = await firestore
            .collection('cart_products')
            .where('cartId', isEqualTo: cartId)
            .where('productId', isEqualTo: cartProduct.productId)
            .get();


        // TODO 상품 추가 기능 완료 후 아래 부분 주석 해제 (중복된 상품 추가 시 수량 추가 기능)
        // if (existingProductQuery.docs.isNotEmpty) {
        //   // 중복 상품 처리 로직
        //   final existingProduct = existingProductQuery.docs.first;
        //   final updatedQuantity =
        //       existingProduct['quantity'] + cartProduct.quantity;
        //
        //   transaction
        //       .update(existingProduct.reference, {'quantity': updatedQuantity});
        //   print(
        //       "CartProductRemoteDataSource : Updated quantity for product ID: ${cartProduct.productId} in cart ID: $cartId");
        // }
        // else {
        //   // Step 4: 새 상품 추가
        //   final cartProductRef = firestore.collection('cart_products').doc();
        //   final newCartProduct = cartProduct.copyWith(
        //     id: cartProductRef.id,
        //     cartId: cartId,
        //   );
        //   transaction.set(
        //       cartProductRef, CartProductMapper.toMap(newCartProduct));
        //   print(
        //       "CartProductRemoteDataSource : Saved product with ID: ${newCartProduct.id} for cart ID: $cartId");
        // }

        // TODO 상품 추가 기능 완료 시 아래 아래 부분 삭제
        // Step 4: 새 상품 추가
        final cartProductRef = firestore.collection('cart_products').doc();
        final newCartProduct = cartProduct.copyWith(
          id: cartProductRef.id,
          cartId: cartId,
        );
        transaction.set(
            cartProductRef, CartProductMapper.toMap(newCartProduct));
      });

      print(
          "CartProductRemoteDataSource : Transaction completed successfully for user ID: $userId");
    } catch (e) {
      print(
          "CartProductRemoteDataSource : Error saving product for user ID: $userId");
      rethrow;
    }
  }

  @override
  Future<void> updateCartProduct(CartProductModel cartProduct) async {
    try {
      print(
          "CartProductRemoteDataSource : Update 상품 ID: ${cartProduct.id} 카트 ID: ${cartProduct.cartId}");

      final productRef =
          firestore.collection('cart_products').doc(cartProduct.id);

      await productRef.update(CartProductMapper.toMap(cartProduct));

      print(
          "CartProductRemoteDataSource : Updated product ID: ${cartProduct.id} for cart ID: ${cartProduct.cartId}");
    } catch (e) {
      print(
          "CartProductRemoteDataSource : Error updating product ID: ${cartProduct.id} for cart ID: ${cartProduct.cartId}");
      rethrow;
    }
  }

  @override
  Future<void> deleteCartProduct(String cartProductId) async {
    try {
      print(
          "CartProductRemoteDataSource : Deleting product ID: $cartProductId");

      final productRef =
          firestore.collection('cart_products').doc(cartProductId);

      final productDoc = await productRef.get();
      if (!productDoc.exists) {
        print(
            "CartProductRemoteDataSource : Product ID: $cartProductId not found");
        throw Exception('Cart product not found');
      }

      await productRef.delete();

      print(
          "CartProductRemoteDataSource : 삭제된 product ID: $cartProductId successfully");
    } catch (e) {
      print(
          "CartProductRemoteDataSource : Error deleting product ID: $cartProductId");
      rethrow;
    }
  }

  @override
  Future<List<CartProductModel>> fetchCartProductsByCartId(String cartId) async {
    try {
      print(
          "CartProductRemoteDataSource -> fetchCartProducts -> cartId : $cartId");

      final querySnapshot = await firestore
          .collection('cart_products')
          .where('cartId', isEqualTo: cartId)
          .get();

      print(
          "CartProductRemoteDataSource -> fetchCartProducts -> querySnapshot : ${querySnapshot.docs.length}");

      final products = querySnapshot.docs
          .map((doc) => CartProductMapper.fromSnapshot(doc))
          .toList();

      print(
          "CartProductRemoteDataSource -> fetchCartProducts -> products.length : ${products.length}, cartId: $cartId");
      return products;
    } catch (e) {
      print(
          "CartProductRemoteDataSource : Error fetching products for cart ID: $cartId");
      rethrow;
    }
  }

  @override
  Future<CartProductModel> fetchCartProductByCartId(
      String cartId, String productId) async {
    try {
      print(
          "CartProductRemoteDataSource : Fetching product ID: $productId for cart ID: $cartId");

      final querySnapshot = await firestore
          .collection('cart_products')
          .where('cartId', isEqualTo: cartId)
          .where('id', isEqualTo: productId)
          .get();

      if (querySnapshot.docs.isEmpty) {
        print(
            "CartProductRemoteDataSource : Product ID: $productId not found for cart ID: $cartId");
        throw Exception('Product not found in cart');
      }

      final product = CartProductMapper.fromSnapshot(querySnapshot.docs.first);

      print(
          "CartProductRemoteDataSource : Fetched product: $product for cart ID: $cartId");
      return product;
    } catch (e) {
      print(
          "CartProductRemoteDataSource : Error fetching product ID: $productId for cart ID: $cartId");
      rethrow;
    }
  }

  Future<void> _saveCart(CartModel cart) async {
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
}

import '../entities/cart_product.dart';

abstract class CartProductRepository {
  Future<void> saveCartProduct(CartProduct cartProduct); // 상품 추가
  Future<List<CartProduct>> fetchCartProductsByCartId(String cartId); // 특정 장바구니의 상품 조회
  Future<void> updateCartProduct(CartProduct cartProduct); // 상품 업데이트
  Future<void> deleteCartProduct(String cartProductId); // 상품 삭제
}
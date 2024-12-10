import '../entities/cart.dart';

abstract class CartRepository {
  Future<void> saveCart(Cart cart);
  Future<Cart?> fetchCartByUserId();
  Future<void> clearCart(String cartId); // 장바구니 비우기
  Future<void> deleteCart(String cartId); // 장바구니 삭제 -> 회원 탈퇴 시
}
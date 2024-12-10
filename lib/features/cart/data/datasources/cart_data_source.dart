import '../model/cart_model.dart';

abstract class CartDataSource {
  Future<CartModel> fetchCartById(String cartId);

  Future<CartModel?> fetchCartByUserId();

  Future<void> saveCart(CartModel cart);

  Future<void> deleteCart(String cartId);

  Future<void> clearCart(String cartId);
}
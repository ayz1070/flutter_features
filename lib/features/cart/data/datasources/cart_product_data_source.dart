import '../model/cart_product_model.dart';

abstract class CartProductDataSource {
  Future<void> saveCartProduct(CartProductModel cartProduct, );
  Future<void> updateCartProduct(CartProductModel cartProduct);
  Future<void> deleteCartProduct(String cartProductId);
  Future<List<CartProductModel>> fetchCartProductsByCartId(String cartId);
  Future<CartProductModel> fetchCartProductByCartId(String cartId, String productId);
}
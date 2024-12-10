import '../../domain/entities/cart_product.dart';
import '../../domain/repositories/cart_product_repository.dart';
import '../datasources/cart_product_data_source.dart';
import '../mapper/cart_product_mapper.dart';

class CartProductRepositoryImpl implements CartProductRepository {
  final CartProductDataSource dataSource;

  CartProductRepositoryImpl({required this.dataSource});

  @override
  Future<void> saveCartProduct(CartProduct cartProduct) async {
    try {
      print("CartProductRepositoryImpl -> addCartProduct -> Input: $cartProduct");
      final cartProductModel = CartProductMapper.toModel(cartProduct);
      print("CartProductRepositoryImpl -> addCartProduct -> Mapped Model: $cartProductModel");
      await dataSource.saveCartProduct(cartProductModel);
      print("CartProductRepositoryImpl -> addCartProduct -> Successfully added product: ${cartProduct.id}");
    } catch (e) {
      print("CartProductRepositoryImpl -> addCartProduct -> Error: $e");
      rethrow;
    }
  }

  @override
  Future<List<CartProduct>> fetchCartProductsByCartId(String cartId) async {
    try {
      print("CartProductRepositoryImpl -> getCartProducts -> Input Cart ID: $cartId");
      final cartProductModels = await dataSource.fetchCartProductsByCartId(cartId);
      print("CartProductRepositoryImpl -> getCartProducts -> Fetched Models: $cartProductModels");
      final cartProducts = cartProductModels.map(CartProductMapper.toEntity).toList();
      // print("CartProductRepositoryImpl -> getCartProducts -> Mapped Entities ID: ${cartProducts.first.id}");
      return cartProducts;
    } catch (e) {
      print("CartProductRepositoryImpl -> getCartProducts -> Error: $e");
      rethrow;
    }
  }

  @override
  Future<void> updateCartProduct(CartProduct cartProduct) async {
    try {
      print("CartProductRepositoryImpl -> updateCartProduct -> Input: $cartProduct");
      final cartProductModel = CartProductMapper.toModel(cartProduct);
      print("CartProductRepositoryImpl -> updateCartProduct -> Mapped Model: $cartProductModel");
      await dataSource.updateCartProduct(cartProductModel);
      print("CartProductRepositoryImpl -> updateCartProduct -> Successfully updated product: ${cartProduct.id}");
    } catch (e) {
      print("CartProductRepositoryImpl -> updateCartProduct -> Error: $e");
      rethrow;
    }
  }

  @override
  Future<void> deleteCartProduct(String cartProductId) async {
    try {
      print("CartProductRepositoryImpl -> deleteCartProduct -> Input Product ID: $cartProductId");
      await dataSource.deleteCartProduct(cartProductId);
      print("CartProductRepositoryImpl -> deleteCartProduct -> Successfully deleted product: $cartProductId");
    } catch (e) {
      print("CartProductRepositoryImpl -> deleteCartProduct -> Error: $e");
      rethrow;
    }
  }

}

import '../../domain/entities/cart.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_data_source.dart';
import '../mapper/cart_mapper.dart';

class CartRepositoryImpl implements CartRepository {
  final CartDataSource dataSource;

  CartRepositoryImpl({required this.dataSource});

  @override
  Future<void> saveCart(Cart cart) async {
    try {
      final cartModel = CartMapper.toModel(cart);
      await dataSource.saveCart(cartModel);
    } catch (e) {
      throw Exception('Failed to save cart: $e');
    }
  }

  @override
  Future<Cart?> fetchCartByUserId() async {
    try {
      final cartModel = await dataSource.fetchCartByUserId();
      if (cartModel == null) return null;
      return CartMapper.toEntity(cartModel);
    } catch (e) {
      throw Exception('Failed to fetch cart by user ID: $e');
    }
  }


  @override
  Future<void> clearCart(String cartId) async {
    try {
      await dataSource.clearCart(cartId);
    } catch (e) {
      throw Exception('Failed to clear cart: $e');
    }
  }

  @override
  Future<void> deleteCart(String cartId) async {
    try {
      await dataSource.deleteCart(cartId);
    } catch (e) {
      throw Exception('CartRepositoryImpl -> cart 삭제 실패: $e');
    }
  }


}

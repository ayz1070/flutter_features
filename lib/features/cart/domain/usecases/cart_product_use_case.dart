
import '../entities/cart.dart';
import '../entities/cart_product.dart';
import '../repositories/cart_product_repository.dart';
import '../repositories/cart_repository.dart';

// 추상 클래스 정의
abstract class CartProductUseCase<Type, Params> {
  Future<Type> call(Params params);
}

class SaveCartProductUseCase extends CartProductUseCase<void, CartProduct> {
  final CartProductRepository cartProductRepository;
  final CartRepository cartRepository;

  SaveCartProductUseCase({required this.cartProductRepository, required this.cartRepository});

  @override
  Future<void> call(CartProduct cartProduct) async {
    try {
      final Cart? cartData = await cartRepository.fetchCartByUserId();
      final String? cartId = cartData?.id;

      print("AddCartProductUseCase -> 입력 cartID: $cartId");
      final List<CartProduct> cartProducts = await cartProductRepository.fetchCartProductsByCartId(cartId!);
      print("AddCartProductUseCase -> cartProducts : $cartProducts");

      final newCartProduct = cartProduct.copyWith(id:cartId);

      await cartProductRepository.saveCartProduct(newCartProduct);

    } catch (e) {
      print("AddCartProductUseCase -> Error: $e");
      rethrow;
    }
  }
}

// fetchCartProductsByCartIdUseCase: 상품 조회
class FetchCartProductsByCartIdUseCase extends CartProductUseCase<List<CartProduct>, String> {
  final CartProductRepository cartProductRepository;

  FetchCartProductsByCartIdUseCase({required this.cartProductRepository});

  @override
  Future<List<CartProduct>> call(String cartId) async {
    try {
      print("fetchCartProductsByCartIdUseCase -> Input Cart ID: $cartId");
      final products = await cartProductRepository.fetchCartProductsByCartId(cartId);
      print("fetchCartProductsByCartIdUseCase -> Fetched Products ID: ${products.first.id}");
      return products;
    } catch (e) {
      print("fetchCartProductsByCartIdUseCase -> Error: $e");
      return [];
    }
  }
}

class UpdateCartProductUseCase
    extends CartProductUseCase<void, CartProduct> {
  final CartProductRepository cartProductRepository;

  UpdateCartProductUseCase({required this.cartProductRepository});

  @override
  Future<void> call(CartProduct cartProduct) async {
    try {
      print("UpdateCartProductUseCase -> Input Params: $cartProduct");

      final List<CartProduct> cartProducts = await cartProductRepository.fetchCartProductsByCartId(cartProduct.cartId!);
      print("UpdateCartProductUseCase -> Existing Cart Products: $cartProducts");

      final CartProduct productToUpdate = cartProducts.firstWhere(
            (item) => item.id == cartProduct.id,
        orElse: () => throw Exception('CartProduct not found'),
      );

      print("UpdateCartProductUseCase -> Product to update: $productToUpdate");

      final updatedProduct = productToUpdate.copyWith(
        quantity: cartProduct.quantity,
        isChecked: cartProduct.isChecked,
      );

      await cartProductRepository.updateCartProduct(updatedProduct);
      print("UpdateCartProductUseCase -> Updated Product: $updatedProduct");
    } catch (e) {
      print("UpdateCartProductUseCase -> Error: $e");
      rethrow;
    }
  }
}

// DeleteCartProductUseCase: 상품 삭제
class DeleteCartProductUseCase extends CartProductUseCase<void, String> {
  final CartProductRepository cartProductRepository;

  DeleteCartProductUseCase({required this.cartProductRepository});

  @override
  Future<void> call(String cartProductId) async {
    try {
      print("DeleteCartProductUseCase -> Input Product ID: $cartProductId");
      await cartProductRepository.deleteCartProduct(cartProductId);
      print("DeleteCartProductUseCase -> Successfully deleted product: $cartProductId");
    } catch (e) {
      print("DeleteCartProductUseCase -> Error: $e");
      rethrow;
    }
  }
}
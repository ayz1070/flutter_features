import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

// 추상 클래스 정의
abstract class CartUseCase<Type, Params> {
  Future<Type?> call(Params params);
}

// CreateCartUseCase: 장바구니 생성
class SaveCartUseCase extends CartUseCase<void, Cart> {
  final CartRepository cartRepository;

  SaveCartUseCase({required this.cartRepository});

  @override
  Future<void> call(Cart cart) async {
    await cartRepository.saveCart(cart);
  }
}

class FetchCartByUserIdUseCase extends CartUseCase<Cart, NoParams> {
  final CartRepository cartRepository;

  FetchCartByUserIdUseCase({required this.cartRepository});

  @override
  Future<Cart?> call(NoParams noParam) async {
    try {
      final cart = await cartRepository.fetchCartByUserId();

      return cart;
    } catch (e) {
      print("Error in FetchCartByUserUseCase: $e");
      rethrow;
    }
  }
}


// ClearCartUseCase: 장바구니 비우기
class ClearCartUseCase extends CartUseCase<void, String> {
  final CartRepository cartRepository;

  ClearCartUseCase({required this.cartRepository});

  @override
  Future<void> call(String cartId) async {
    await cartRepository.clearCart(cartId);
  }
}

class CheckoutCartUseCase extends CartUseCase<void, Cart> {
  final CartRepository cartRepository;

  CheckoutCartUseCase({required this.cartRepository});

  @override
  Future<void> call(Cart cart) async {
    await cartRepository.saveCart(cart);
  }
}

// 장바구니 삭제 (회원 탈퇴 시 수행)
class DeleteCartUseCase extends CartUseCase<void, String> {
  final CartRepository cartRepository;

  DeleteCartUseCase({required this.cartRepository});

  @override
  Future<void> call(String cartId) async {
    await cartRepository.deleteCart(cartId);
  }
}

class NoParams {}
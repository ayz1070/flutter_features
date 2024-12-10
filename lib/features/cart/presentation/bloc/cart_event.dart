import 'package:equatable/equatable.dart';
import '../../domain/entities/cart.dart';
import '../../domain/entities/cart_product.dart';
import '../vm/cart_product_view_model.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCartEvent extends CartEvent {

  LoadCartEvent();

  @override
  List<Object?> get props => [];
}

class AddCartProductEvent extends CartEvent {
  final CartProduct cartProduct;

  AddCartProductEvent(this.cartProduct);

  @override
  List<Object?> get props => [cartProduct];
}

class UpdateCartProductEvent extends CartEvent {
  final String cartProductId;
  final int? quantity; // 수량 (Optional)
  final bool? isSelected; // 선택 여부 (Optional)

  UpdateCartProductEvent({
    required this.cartProductId,
    this.quantity,
    this.isSelected,
  });

  @override
  List<Object?> get props => [cartProductId, quantity, isSelected];
}


class QuantityChangeEvent extends CartEvent {
  final String cartProductId; // 변경할 카트 제품 ID
  final int quantity;         // 변경할 수량

  QuantityChangeEvent({
    required this.cartProductId,
    required this.quantity,
  });

  @override
  List<Object?> get props => [cartProductId, quantity];
}

class RemoveCartProductEvent extends CartEvent {
  final String cartProductId;

  RemoveCartProductEvent(this.cartProductId);

  @override
  List<Object?> get props => [cartProductId];
}

// ClearCartEvent: 카트 비우기
class ClearCartEvent extends CartEvent {
  final String cartId;

  ClearCartEvent(this.cartId);

  @override
  List<Object?> get props => [cartId];
}

class CheckoutCartEvent extends CartEvent {
  final Cart cart;

  CheckoutCartEvent(this.cart);

  @override
  List<Object?> get props => [cart];
}

// ToggleSelectAllEvent: 모든 상품 선택/선택 해제
class ToggleSelectAllEvent extends CartEvent {
  final bool isSelected;

  ToggleSelectAllEvent(this.isSelected);

  @override
  List<Object?> get props => [isSelected];
}

class ToggleSelectOneEvent extends CartEvent {
  final String cartProductId;
  final bool isSelected;

  ToggleSelectOneEvent({
    required this.cartProductId,
    required this.isSelected,
  });

  @override
  List<Object?> get props => [cartProductId, isSelected];
}

// RefreshCartSummaryEvent: 카트 요약 정보 업데이트
class RefreshCartSummaryEvent extends CartEvent {
  final List<CartProduct> cartProducts;

  RefreshCartSummaryEvent(this.cartProducts);

  @override
  List<Object?> get props => [cartProducts];
}

class UpdateAllCartProductsEvent extends CartEvent {
  final List<CartProductViewModel> allProducts;

  UpdateAllCartProductsEvent(this.allProducts);

  @override
  List<Object?> get props => [allProducts];
}

import 'package:equatable/equatable.dart';

import '../vm/cart_product_view_model.dart';
import '../vm/cart_summary_view_model.dart';

abstract class CartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {
  final List<CartProductViewModel> cartProducts; // CartProductViewModel 리스트
  final CartSummaryViewModel cartSummary; // CartSummaryViewModel

  CartLoadedState({
    required this.cartProducts,
    required this.cartSummary,
  });

  @override
  List<Object?> get props => [cartProducts, cartSummary];
}

class CartErrorState extends CartState {
  final String error;

  CartErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class CartCheckoutSuccessState extends CartState {}

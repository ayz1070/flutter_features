import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/cart.dart';
import '../../domain/entities/cart_product.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/cart_product_use_case.dart';
import '../../domain/usecases/cart_use_case.dart';
import '../vm/cart_product_view_model.dart';
import '../vm/cart_summary_view_model.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final FetchCartProductsByCartIdUseCase fetchCartProductsByCartIdUseCase;
  final UpdateCartProductUseCase updateCartProductUseCase;
  final DeleteCartProductUseCase deleteCartProductUseCase;
  final CheckoutCartUseCase checkoutCartUseCase;
  final FetchCartByUserIdUseCase fetchCartByUserIdUseCase;

  CartBloc({
    required this.fetchCartProductsByCartIdUseCase,
    required this.updateCartProductUseCase,
    required this.deleteCartProductUseCase,
    required this.checkoutCartUseCase,
    required this.fetchCartByUserIdUseCase,
  }) : super(CartInitialState()) {
    on<LoadCartEvent>(_onLoadCart);
    on<ToggleSelectAllEvent>(_onToggleSelectAll);
    on<UpdateCartProductEvent>(_onUpdateCartProduct);
    on<RemoveCartProductEvent>(_onRemoveCartProduct);
    on<ToggleSelectOneEvent>(_onToggleSelectOne);
    on<QuantityChangeEvent>(_onChangeQuantity);
    on<CheckoutCartEvent>(_onCheckoutCart);
    on<UpdateAllCartProductsEvent>(_onUpdateAllCartProducts); // 새 이벤트 등록
  }

  Future<void> _onLoadCart(LoadCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());

    try {
      //await Future.delayed(Duration(seconds: 2));
      // Step 1: cart fetch 후 그 id로 cartProduct fetch
      final cart = await fetchCartByUserIdUseCase(NoParams());
      final cartProducts = await fetchCartProductsByCartIdUseCase(cart!.id!);

      // Step 2: product fetch 후 그에 ViewModel에 맵핑
      final cartProductViewModels = cartProducts.map((cartProduct) {
        final product = _fetchProduct(cartProduct.productId!);
        return CartProductViewModel.fromEntity(cartProduct, product, cart);
      }).toList();

      // Step 3: 계산 후 ViewModel 맵핑
      final cartSummary = _calculateCartSummary(cartProductViewModels);

      emit(CartLoadedState(
        cartProducts: cartProductViewModels,
        cartSummary: cartSummary,
      ));
    } catch (e) {
      emit(CartErrorState(e.toString()));
    }
  }

  Future<void> _onToggleSelectAll(
      ToggleSelectAllEvent event, Emitter<CartState> emit) async {
    if (state is CartLoadedState) {
      final currentState = state as CartLoadedState;

      final updatedProducts = currentState.cartProducts
          .map((product) => product.copyWith(isSelected: event.isSelected))
          .toList();

      final updatedSummary = _calculateCartSummary(updatedProducts);

      emit(CartLoadedState(
        cartProducts: updatedProducts,
        cartSummary: updatedSummary,
      ));
    }
  }

  Future<void> _onToggleSelectOne(
      ToggleSelectOneEvent event, Emitter<CartState> emit) async {
    if (state is CartLoadedState) {
      final currentState = state as CartLoadedState;

      final updatedProducts = currentState.cartProducts.map((product) {
        if (product.id == event.cartProductId) {
          return product.copyWith(isSelected: event.isSelected);
        }
        return product;
      }).toList();

      final updatedSummary = _calculateCartSummary(updatedProducts);

      emit(CartLoadedState(
        cartProducts: updatedProducts,
        cartSummary: updatedSummary,
      ));
    }
  }

  Future<void> _onUpdateCartProduct(
      UpdateCartProductEvent event, Emitter<CartState> emit) async {
    try {
      if (state is CartLoadedState) {
        final currentState = state as CartLoadedState;
        // 업데이트할 상품 찾기
        final productToUpdate = currentState.cartProducts.firstWhere(
              (product) => product.id == event.cartProductId,
        );

        // 업데이트된 상품 생성
        final updatedProduct = productToUpdate.copyWith(
          quantity: event.quantity,
          isSelected: event.isSelected,
        );

        // UseCase 호출로 서버 업데이트
        await updateCartProductUseCase(CartProduct(
          id: updatedProduct.id,
          productId: updatedProduct.productId,
          cartId: updatedProduct.cartId,
          quantity: updatedProduct.quantity,
          createdAt: DateTime.now(),
          isChecked: updatedProduct.isSelected,
        ));

        // 상태 갱신
        final updatedProducts = currentState.cartProducts.map((product) {
          if (product.id == event.cartProductId) {
            return updatedProduct;
          }
          return product;
        }).toList();

        final updatedSummary = _calculateCartSummary(updatedProducts);

        emit(CartLoadedState(
          cartProducts: updatedProducts,
          cartSummary: updatedSummary,
        ));
      }
    } catch (e) {
      emit(CartErrorState(e.toString()));
    }
  }


  Future<void> _onChangeQuantity(
      QuantityChangeEvent event, Emitter<CartState> emit) async {
    if (state is CartLoadedState) {
      final currentState = state as CartLoadedState;

      // UI 상태만 업데이트
      final updatedProducts = currentState.cartProducts.map((product) {
        if (product.id == event.cartProductId) {
          return product.copyWith(quantity: event.quantity); // 수량 변경
        }
        return product;
      }).toList();

      // 요약 정보 재계산
      final updatedSummary = _calculateCartSummary(updatedProducts);

      // 상태 업데이트
      emit(CartLoadedState(
        cartProducts: updatedProducts,
        cartSummary: updatedSummary,
      ));
    }
  }

  Future<void> _onRemoveCartProduct(
      RemoveCartProductEvent event, Emitter<CartState> emit) async {
    try {
      if (state is CartLoadedState) {
        final currentState = state as CartLoadedState;

        // 삭제된 상품을 제외한 새로운 리스트 생성
        final updatedProducts = currentState.cartProducts
            .where((product) => product.id != event.cartProductId)
            .toList();

        // 요약 정보 재계산
        final updatedSummary = _calculateCartSummary(updatedProducts);

        // 상태 갱신
        emit(CartLoadedState(
          cartProducts: List.from(updatedProducts), // 새로운 객체로 전달
          cartSummary: updatedSummary,
        ));

        // 서버에서도 삭제 처리
        await deleteCartProductUseCase(event.cartProductId);
      }
    } catch (e) {
      emit(CartErrorState(e.toString()));
    }
  }


  Future<void> _onCheckoutCart(
      CheckoutCartEvent event, Emitter<CartState> emit) async {
    try {
      if (state is CartLoadedState) {
        final currentState = state as CartLoadedState;

        // 서버로 업데이트할 데이터 생성
        for (final product in currentState.cartProducts) {
          await updateCartProductUseCase(
            CartProduct(
              id: product.id,
              productId: product.productId,
              cartId: event.cart.id!,
              quantity: product.quantity,
              createdAt: DateTime.now(),
              isChecked: product.isSelected,
            ),
          );
        }

        // 결제 완료 상태로 전환
        await checkoutCartUseCase(event.cart);

        emit(CartCheckoutSuccessState());
      }
    } catch (e) {
      emit(CartErrorState(e.toString()));
    }
  }

  Product _fetchProduct(String productId) {
    //TODO : Product 테스트 데이터 상품 완료되면 수정하기
    Product testProduct = Product(
        id: "test_product_id",
        name: "[애플] 2중 기능성 앰플",
        brand: "brand",
        category: "category",
        description: "description",
        imageUrl: "https://picsum.photos/200/300",
        price: 10000,
        discountPrice: 2000,
        discountRate: 20,
        expirationDate: "expirationDate",
        caution: "caution",
        delivery: "delivery",
        ingredients: "ingredients",
        qna: "qna",
        review: "review",
        specificationType: "specificationType",
        userId: "test_user_id",
        volume: "volume",
        whetherAudit: "whetherAudit");
    return testProduct;
  }

  CartSummaryViewModel _calculateCartSummary(
      List<CartProductViewModel> cartProducts) {
    final selectedProducts =
        cartProducts.where((product) => product.isSelected).toList();

    final totalQuantity = selectedProducts.fold<int>(
      0,
      (sum, product) => sum + product.quantity,
    );

    final totalPrice = selectedProducts.fold<double>(
      0.0,
      (sum, product) => sum + (product.price * product.quantity),
    );

    final totalDiscountPrice = selectedProducts.fold<double>(
      0.0,
      (sum, product) => sum + (product.discountPrice * product.quantity),
    );

    final deliveryFee =
        selectedProducts.isNotEmpty ? 2500.0 : 0.0; // 선택된 상품이 없으면 배송비 0 처리

    return CartSummaryViewModel(
      totalPrice: totalPrice,
      totalDiscountPrice: totalDiscountPrice,
      deliveryFee: deliveryFee,
      totalQuantity: totalQuantity,
    );
  }

  Future<void> _onUpdateAllCartProducts(
      UpdateAllCartProductsEvent event, Emitter<CartState> emit) async {
    if (state is CartLoadedState) {
      final currentState = state as CartLoadedState;

      try {
        // 모든 상품의 현재 상태를 서버와 동기화
        for (final viewModel in event.allProducts) {
          final cartProduct = viewModel.toCartProductEntity();
          await updateCartProductUseCase(cartProduct);
        }

        // UI 갱신 (선택 상태 유지)
        emit(CartLoadedState(
          cartProducts: currentState.cartProducts,
          cartSummary: currentState.cartSummary,
        ));
      } catch (e) {
        emit(CartErrorState(e.toString()));
      }
    }
  }
}

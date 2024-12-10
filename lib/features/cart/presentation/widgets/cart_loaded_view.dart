import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_features/features/cart/presentation/widgets/select_all_check_box.dart';
import '../../domain/entities/cart.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../vm/cart_product_view_model.dart';
import '../vm/cart_summary_view_model.dart';
import '../widgets/cart_list_view.dart';
import 'cart_explain_text.dart';
import 'cart_summary_view.dart';

class CartLoadedView extends StatelessWidget {
  final List<CartProductViewModel> cartProducts;
  final CartSummaryViewModel cartSummary;

  const CartLoadedView({
    Key? key,
    required this.cartProducts,
    required this.cartSummary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allSelected = cartProducts.every((item) => item.isSelected);

    return ListView(
      children: [
        SelectAllCheckbox(
          isSelected: allSelected,
          onToggle: (isSelected) {
            context.read<CartBloc>().add(ToggleSelectAllEvent(isSelected));
          },
        ),

        CartListView(
          cartProducts: cartProducts,
          onToggleItem: (cartProductId, isSelected) {
            context.read<CartBloc>().add(ToggleSelectOneEvent(
              cartProductId: cartProductId,
              isSelected: isSelected,
            ));
          },
          onUpdateQuantity: (cartProductId, quantity) {
            context.read<CartBloc>().add(QuantityChangeEvent(
              cartProductId: cartProductId,
              quantity: quantity,
            ),);
          },
          onDeleteItem: (String cartProductId) {
            context.read<CartBloc>().add(RemoveCartProductEvent(cartProductId));
          },
        ),
        SizedBox(height: 16,),
        CartSummaryView(
          quantity: cartSummary.totalQuantity,
          totalPrice: cartSummary.totalPrice,
          discount: cartSummary.totalDiscountPrice,
          deliveryFee: cartSummary.deliveryFee,
          finalPrice: cartSummary.finalPrice,
          rewardPoints: cartSummary.totalPrice * 0.01,
          onPressed: () {
            // CheckoutCartEvent 생성 시 필요한 Cart 객체 생성
            final cart = Cart(
              id: "test_cart_id",
              userId: "test_user_id",
              deliveryPolicyId: "defaultPolicy",
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            );
            context.read<CartBloc>().add(CheckoutCartEvent(cart));
          },
        ),
        CartExplainText(),
      ],
    );
  }
}

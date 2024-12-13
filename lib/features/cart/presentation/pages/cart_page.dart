import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_features/features/cart/presentation/pages/skeleton_cart_page.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';
import '../widgets/cart_app_bar.dart';
import '../widgets/cart_empty_view.dart';
import '../widgets/cart_loaded_view.dart';
import '../widgets/cart_page_button.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(LoadCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoadingState) {
          return SkeletonCartPage();
        } else if (state is CartLoadedState) {
          // cartProducts가 비어있는 경우 CartEmptyView 반환
          if (state.cartProducts.isEmpty) {
            return Scaffold(
              appBar: CartAppBar(
                  title: "장바구니", onBackPressed: Navigator.of(context).pop),
              body: CartEmptyView(),
            );
          }

          // cartProducts가 비어있지 않은 경우 CartLoadedView 반환
          return Scaffold(
            appBar: CartAppBar(
                title: "장바구니", onBackPressed: Navigator.of(context).pop),
            body: SafeArea(
              child: CartLoadedView(
                cartProducts: state.cartProducts,
                cartSummary: state.cartSummary,
              ),
            ),
            persistentFooterButtons: [
              CartPageButton(
                totalPrice: state.cartSummary.totalPrice,
                finalPrice: state.cartSummary.finalPrice,
                paddingHorizontal: EdgeInsets.symmetric(horizontal: 0),
                onPressed: () {
                  final currentState = state as CartLoadedState;

                  // 모든 상품 가져오기
                  final allProducts = currentState.cartProducts;

                  // 모든 상품 업데이트 이벤트 호출
                  context.read<CartBloc>().add(UpdateAllCartProductsEvent(allProducts));
                },
              ),

            ],
          );
        } else if (state is CartErrorState) {
          return Center(
            child: Text(
              '오류가 발생했습니다: ${state.error}',
              style: AppTextStyles.regular14,
            ),
          );
        } else {
          return CartEmptyView();
        }
      },
    );
  }
}

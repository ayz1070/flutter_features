import 'package:flutter/material.dart';
import '../vm/cart_product_view_model.dart';
import 'cart_delete_dialog.dart';
import 'cart_item.dart';

class CartListView extends StatelessWidget {
  final List<CartProductViewModel> cartProducts;
  final Function(String cartProductId, bool isSelected) onToggleItem;
  final Function(String cartProductId, int quantity) onUpdateQuantity;
  final Function(String cartProductId) onDeleteItem; // 삭제 콜백 추가

  const CartListView({
    Key? key,
    required this.cartProducts,
    required this.onToggleItem,
    required this.onUpdateQuantity,
    required this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      itemCount: cartProducts.length,
      itemBuilder: (context, index) {
        final item = cartProducts[index];
        return CartItem(
          item: item,
          onToggle: (isSelected) {
            onToggleItem(item.id!, isSelected);
          },
          onUpdateQuantity: (quantity) {
            onUpdateQuantity(item.id!, quantity);
          },
          onDelete: () {
            _showDeleteDialog(context, item.id!); // 삭제 다이얼로그 호출
          },
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 16), // 간격 추가
    );
  }

  void _showDeleteDialog(BuildContext context, String cartProductId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CartDeleteDialog(cartProductId: cartProductId, onDeleteItem: onDeleteItem);
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/formatter.dart';
import '../../../../core/widgets/quantity_selector.dart';
import '../../../../core/widgets/rectangle_checkbox.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../vm/cart_product_view_model.dart';
import 'cart_buy_button.dart';
import 'cart_delete_button.dart';

class CartItem extends StatelessWidget {
  final CartProductViewModel item;
  final ValueChanged<bool> onToggle;
  final ValueChanged<int> onUpdateQuantity;
  final VoidCallback onDelete;

  const CartItem({
    Key? key,
    required this.item,
    required this.onToggle,
    required this.onUpdateQuantity,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.backgroundPrimaryColor,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RectangleCheckbox(
                value: item.isSelected,
                onChanged: (value) {
                  onToggle(value ?? false);
                },
              ),
              SizedBox(
                width: 8,
              ),
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Image.network(
                      item.imageUrl,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 11),
                  QuantitySelector(
                    quantity: item.quantity,
                    onQuantityChanged: (newQuantity) {
                      onUpdateQuantity(newQuantity);
                    },
                  ),
                ],
              ),
              SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "스토어 (데이터 필요함)",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    item.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    '옵션 : (뭔값임?)',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '구매 수량 : ${item.quantity}',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Spacer(),
              CartDeleteButton(onPressed: onDelete),

            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              SizedBox(width: 40,),
              Text(
                '${Formatter.formatPrice(item.price)}',
                style: AppTextStyles.regular12.copyWith(
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Color(0xFF666666),
                )
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                '${Formatter.formatPrice(item.price - item.discountPrice)}',
                style: AppTextStyles.semiBold15,
              ),
              Spacer(),
              CartBuyButton(title: "바로구매하기", onPressed: onDelete)
            ],
          ),
        ],
      ),
    );
  }
}

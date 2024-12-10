import '../../domain/entities/cart.dart';
import '../../domain/entities/cart_product.dart';
import '../../domain/entities/product.dart';

class CartProductViewModel {
  final String? id;
  final String productId;
  final String? cartId;
  final String name;
  final String imageUrl;
  final int quantity;
  final double price;
  final double discountPrice;
  final bool isSelected;

  CartProductViewModel({
    this.id,
    required this.productId,
    this.cartId,
    required this.name,
    required this.imageUrl,
    required this.quantity,
    required this.price,
    required this.discountPrice,
    this.isSelected = true,
  });

  factory CartProductViewModel.fromEntity(
      CartProduct cartProduct,
      Product product,
      Cart cart,
      ) {
    return CartProductViewModel(
      id: cartProduct.id,
      productId: product.id,
      cartId: cart.id,
      name: product.name,
      imageUrl: product.imageUrl,
      quantity: cartProduct.quantity,
      price: product.price,
      discountPrice: product.discountPrice,
      isSelected: cartProduct.isChecked, // 선택 여부 반영
    );
  }

  CartProduct toCartProductEntity() {
    return CartProduct(
      id: id,
      productId: productId,
      cartId: cartId,
      quantity: quantity,
      createdAt: DateTime.now(),
      isChecked: isSelected,
    );
  }

  CartProductViewModel copyWith({
    String? id,
    String? productId,
    String? cartId,
    String? name,
    String? imageUrl,
    int? quantity,
    double? price,
    double? discountPrice,
    bool? isSelected,
  }) {
    return CartProductViewModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      cartId: cartId ?? this.cartId,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      discountPrice: discountPrice ?? this.discountPrice,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

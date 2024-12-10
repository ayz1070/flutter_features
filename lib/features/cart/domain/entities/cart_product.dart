class CartProduct {
  final String? id;
  final String? productId;
  String? cartId;
  final int quantity;
  final DateTime createdAt;
  final bool isChecked;

  CartProduct({
    this.id,
    this.productId,
    this.cartId,
    required this.quantity,
    required this.createdAt,
    this.isChecked = true,
  });

  CartProduct copyWith({
    String? id,
    String? productId,
    String? cartId,
    int? quantity,
    DateTime? createdAt,
    bool? isChecked,
  }) {
    return CartProduct(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      cartId: cartId ?? this.cartId,
      quantity: quantity ?? this.quantity,
      createdAt: createdAt ?? this.createdAt,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}
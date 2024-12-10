class CartProductModel {
  final String? id;
  final String? productId;
  String? cartId;
  final int quantity;
  final DateTime createdAt;
  final bool isChecked;

  CartProductModel({
    this.id,
    this.productId,
    this.cartId,
    required this.quantity,
    required this.createdAt,
    this.isChecked = true,
  });

  CartProductModel copyWith({
    String? id,
    String? productId,
    String? cartId,
    int? quantity,
    DateTime? createdAt,
  }) {
    return CartProductModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      cartId: cartId ?? this.cartId,
      quantity: quantity ?? this.quantity,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
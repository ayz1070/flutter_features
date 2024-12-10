class CartSummaryViewModel {
  final double totalPrice;
  final double totalDiscountPrice;
  final double deliveryFee;
  final int totalQuantity;

  CartSummaryViewModel({
    required this.totalPrice,
    required this.totalDiscountPrice,
    this.deliveryFee = 0.0,
    int? totalQuantity,
  }) : totalQuantity = totalQuantity ?? 0;

  double get finalPrice => totalPrice - totalDiscountPrice + deliveryFee;
}
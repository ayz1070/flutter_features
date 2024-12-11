class PurchasedProduct {
  final String id;
  final String productId;
  final String userId;
  final DateTime purchaseDate;
  final int quantity;
  final int purchasePrice;
  final bool isReviewed;

  PurchasedProduct({
    required this.id,
    required this.productId,
    required this.userId,
    required this.purchaseDate,
    required this.quantity,
    required this.purchasePrice,
    required this.isReviewed,
  });
}
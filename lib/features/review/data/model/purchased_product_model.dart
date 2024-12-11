class PurchasedProductModel {
  final String id;           // 구매 내역 ID
  final String productId;     // 상품 ID
  final String userId;        // 사용자 ID
  final DateTime purchaseDate;// 구매한 날짜
  final int quantity;         // 구매한 수량
  final int purchasePrice; // 구매 시 가격
  final bool isReviewed;

  PurchasedProductModel({
    required this.id,
    required this.productId,
    required this.userId,
    required this.purchaseDate,
    required this.quantity,
    required this.purchasePrice,
    this.isReviewed = false,
  });

  PurchasedProductModel copyWith({
    String? id,
    String? productId,
    String? userId,
    DateTime? purchaseDate,
    int? quantity,
    int? purchasePrice,
    bool? isReviewed,
  }) {
    return PurchasedProductModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      userId: userId ?? this.userId,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      quantity: quantity ?? this.quantity,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      isReviewed: isReviewed ?? this.isReviewed,
    );
  }
}
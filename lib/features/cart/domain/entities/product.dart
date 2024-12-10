class Product {
  final String id;
  final String name;
  final String brand;
  final String category;
  final String description;
  final String imageUrl;
  final double price;
  final double discountPrice;
  final double discountRate;
  final String expirationDate;
  final String caution;
  final String delivery;
  final String ingredients;
  final String qna;
  final String review;
  final String specificationType;
  final String userId;
  final String volume;
  final String whetherAudit;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.discountPrice,
    required this.discountRate,
    required this.expirationDate,
    required this.caution,
    required this.delivery,
    required this.ingredients,
    required this.qna,
    required this.review,
    required this.specificationType,
    required this.userId,
    required this.volume,
    required this.whetherAudit,
  });
}
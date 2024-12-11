class ReviewModel{
  final String reviewId;
  final String userId;
  final String productId;
  final double rating;
  final String? content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> imageUrls;

  ReviewModel({
    required this.reviewId,
    required this.userId,
    required this.productId,
    required this.rating,
    this.content = '',
    required this.createdAt,
    required this.updatedAt,
    required this.imageUrls,
  });

  ReviewModel copyWith({
    String? reviewId,
    String? userId,
    String? productId,
    double? rating,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? imageUrls,
  }) {
    return ReviewModel(
      reviewId: reviewId ?? this.reviewId,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
      rating: rating ?? this.rating,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      imageUrls: imageUrls ?? List.from(this.imageUrls),
    );
  }
}
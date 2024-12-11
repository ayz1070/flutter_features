import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String name;
  final String brand;
  final String category;
  final String description;
  final String imageUrl;
  final int price;
  final int discountPrice;
  final int discountRate;
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

  ProductModel({
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

  /// Firestore 데이터를 `ProductModel`로 변환
  factory ProductModel.fromMap(Map<String, dynamic> map, {String? id}) {
    return ProductModel(
      id: id ?? map['id'], // 문서 ID를 우선 사용
      name: map['name'] as String,
      brand: map['brand'] as String,
      category: map['category'] as String,
      description: map['description'] as String,
      imageUrl: map['imageUrl'] as String,
      price: map['price'] as int,
      discountPrice: map['discountPrice'] as int,
      discountRate: map['discountRate'] as int,
      expirationDate: map['expirationDate'] as String,
      caution: map['caution'] as String,
      delivery: map['delivery'] as String,
      ingredients: map['ingredients'] as String,
      qna: map['qna'] as String,
      review: map['review'] as String,
      specificationType: map['specificationType'] as String,
      userId: map['userId'] as String,
      volume: map['volume'] as String,
      whetherAudit: map['whetherAudit'] as String,
    );
  }

  /// Firestore `DocumentSnapshot`을 `ProductModel`로 변환
  factory ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ProductModel.fromMap(data, id: snapshot.id);
  }
}
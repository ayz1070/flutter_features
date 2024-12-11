import 'package:equatable/equatable.dart';

class ProductViewModel extends Equatable {
  final String productId;
  final DateTime purchaseDate;
  final String productName;
  final String productImageUrl;

  const ProductViewModel({
    required this.productId,
    required this.purchaseDate,
    required this.productName,
    required this.productImageUrl,
  });

  @override
  List<Object?> get props => [productId, purchaseDate, productName, productImageUrl];
}
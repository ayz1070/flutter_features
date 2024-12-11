import '../model/purchased_product_model.dart';

abstract class PurchasedProductDataSource {
  Future<List<PurchasedProductModel>> fetchPurchasedProductsByUser(String userId);
}
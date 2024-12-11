
abstract class PurchasedProductRepository {
  Future<List<Map<String, dynamic>>> fetchPurchasedProductsWithDetails(String userId);
}
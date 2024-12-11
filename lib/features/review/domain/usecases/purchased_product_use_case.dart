
import '../repositories/purchased_product_repository.dart';

abstract class PurchasedProductUseCase<Type, Params> {
  Future<Type> call(Params params);
}

class FetchPurchasedProductsWithDetailsUseCase extends PurchasedProductUseCase<List<Map<String, dynamic>>, String> {
  final PurchasedProductRepository repository;

  FetchPurchasedProductsWithDetailsUseCase(this.repository);

  @override
  Future<List<Map<String, dynamic>>> call(String userId) async {
    try {
      //logger.i("FetchPurchasedProductsWithDetailsUseCase: 유저 아이디 $userId.");

      final products = await repository.fetchPurchasedProductsWithDetails(userId);

      //logger.i("FetchPurchasedProductsWithDetailsUseCase: Successfully fetched purchased products for user $userId.");
      return products;
    } catch (e, stacktrace) {
      //logger.e("Error in FetchPurchasedProductsWithDetailsUseCase: Failed to fetch purchased products for user $userId.");
      throw Exception("UseCase: 구매한 상품과 상세 정보를 가져오는 중 오류 발생. $e");
    }
  }
}
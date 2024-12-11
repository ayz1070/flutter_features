import '../../domain/repositories/purchased_product_repository.dart';
import '../datasources/product_data_source.dart';
import '../datasources/purchased_product_data_source.dart';


class PurchasedProductRepositoryImpl implements PurchasedProductRepository {
  final PurchasedProductDataSource purchasedProductRemoteDataSource;
  final ProductDataSource productDataSource;

  PurchasedProductRepositoryImpl({
    required this.purchasedProductRemoteDataSource,
    required this.productDataSource,
  });

  Future<List<Map<String, dynamic>>> fetchPurchasedProductsWithDetails(String userId) async {
    // 1. 구매한 상품 데이터를 가져옴
    final purchasedProductModels = await purchasedProductRemoteDataSource.fetchPurchasedProductsByUser(userId);

    if (purchasedProductModels.isEmpty) {
      return [];
    }

    // 2. productId를 추출하고 중복 제거
    final productIds = purchasedProductModels.map((product) => product.productId).toSet().toList();

    // 3. Product 정보를 배치로 가져옴
    final productModels = await productDataSource.fetchProductsByIds(productIds);

    // 4. Product 데이터를 Map으로 변환하여 빠르게 접근할 수 있도록 구성
    final productDataMap = {for (var product in productModels) product.id: product};

    // 5. 구매한 상품과 그에 대한 Product 정보를 매핑
    return purchasedProductModels.map((purchasedProduct) {
      final productDetails = productDataMap[purchasedProduct.productId];

      if (productDetails == null) {
        print("PurchasedProductRepositoryImpl : ${purchasedProduct.productId}에 해당하는 제품 정보가 없습니다.");
        return {
          "purchasedProduct": purchasedProduct,
          "productDetails": null
        };
      }

      return {
        "purchasedProduct": purchasedProduct,
        "productDetails": productDetails,
      };
    }).toList();
  }
}
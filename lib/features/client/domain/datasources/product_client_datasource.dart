import '../entities/entities.dart';

abstract class ProductClientDatasource {
  Future<ProductClient> getProductById({int idProduct = 0});

  Future<ProductClient?> getProductWithDiscountById({int idproduct = 0});

  Future<List<ProductClient>> getProducts();

  Future<List<ProductClient>> getProductsOutstanding();

  Future<int> getAmountProducts();

  Future<List<ProductClient>> searchProducts(String textSearch);

  Stream<List<ProductClient>> searchProductsStream(String textSearch);

  Stream<List<ProductClient>> getProductsStream();

  // Future<List<ProductClient>> getProducts
  Future<List<ProductClient>> getProductsByCategory(String idCategory);

  Future<List<ProductClient>> getProductsWithDiscount();
}

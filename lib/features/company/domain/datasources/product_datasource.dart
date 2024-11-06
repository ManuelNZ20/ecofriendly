import '../entities/product.dart';

abstract class ProductDatasource {
  Future<Product> createProduct({
    String nameProduct,
    String brand,
    String description,
    bool status,
    String img,
    double price,
    int amount,
    DateTime expireProduct,
    int idCategory,
  });

  Future<void> deleteProduct(String id);
  Stream<List<Product>> getProductsStream();
  Future<Product> updateProduct({
    int idProduct,
    String nameProduct,
    String brand,
    String description,
    bool status,
    String img,
    double price,
    int amount,
    DateTime updateAt,
    DateTime expireProduct,
    int idCategory,
  });

  Future<Product> updateProductCheck({
    required int idProduct,
    required String nameProduct,
    required String brand,
    required String description,
    required bool status,
    required String img,
    required double price,
    required int amount,
    required DateTime? updateAt,
    required DateTime? expireProduct,
    required int idCategory,
    required bool changedImage,
  });

  Future<Product> getProductById({int idProduct = 0});

  Future<Product?> getProductWithDiscountById({int idproduct = 0});

  Future<List<Product>> getProducts();

  Future<List<Product>> getProductsOutstanding();

  Future<List<Product>> getProductsByCompany(String idCompany);

  Future<List<Product>> getProductsByInventory(int idInventory);

  Future<int> getAmountProducts();

  Future<List<Product>> searchProducts(String textSearch);

  Stream<List<Product>> searchProductsStrean(String textSearch);
}

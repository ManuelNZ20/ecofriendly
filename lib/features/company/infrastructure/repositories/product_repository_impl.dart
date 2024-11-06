import 'package:supabase_flutter/supabase_flutter.dart';
import '../datasources/product_datasources_impl.dart';
import '../../domain/domain.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDatasource productDataSource;
  final SupabaseClient supabaseClient;

  ProductRepositoryImpl({
    ProductDatasource? productDataSource,
    required this.supabaseClient,
  }) : productDataSource = productDataSource ??
            ProductDatasourceImpl(
              supabaseClientDatasource: supabaseClient,
            );

  @override
  Future<int> getAmountProducts() async {
    return await productDataSource.getAmountProducts();
  }

  @override
  Future<Product> createProduct({
    String nameProduct = '',
    String brand = '',
    String description = '',
    bool status = false,
    String img = '',
    double price = 0.0,
    int amount = 0,
    DateTime? expireProduct,
    int idCategory = 0,
  }) async {
    try {
      return await productDataSource.createProduct(
        nameProduct: nameProduct,
        brand: brand,
        description: description,
        status: status,
        img: img,
        price: price,
        amount: amount,
        expireProduct: expireProduct!,
        idCategory: idCategory,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    throw UnimplementedError();
  }

  @override
  Future<Product> updateProduct({
    int idProduct = 0,
    String nameProduct = '',
    String brand = '',
    String description = '',
    bool status = false,
    String img = '',
    double price = 0.0,
    int amount = 0,
    DateTime? updateAt,
    DateTime? expireProduct,
    int idCategory = 0,
  }) async {
    try {
      return await productDataSource.updateProduct(
        idProduct: idProduct,
        nameProduct: nameProduct,
        brand: brand,
        description: description,
        status: status,
        img: img,
        price: price,
        amount: amount,
        expireProduct: expireProduct!,
        updateAt: updateAt!,
        idCategory: idCategory,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Product> getProductById({int idProduct = 0}) async {
    final product =
        await productDataSource.getProductById(idProduct: idProduct);
    return product;
  }

  @override
  Future<List<Product>> getProducts() async {
    return await productDataSource.getProducts();
  }

  @override
  Future<List<Product>> getProductsOutstanding() async {
    return await productDataSource.getProductsOutstanding();
  }

  @override
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
  }) async {
    final product = await productDataSource.updateProductCheck(
      idProduct: idProduct,
      nameProduct: nameProduct,
      brand: brand,
      description: description,
      status: status,
      img: img,
      price: price,
      amount: amount,
      updateAt: updateAt,
      expireProduct: expireProduct,
      idCategory: idCategory,
      changedImage: changedImage,
    );
    return product;
  }

  @override
  Future<Product?> getProductWithDiscountById({int idproduct = 0}) async {
    try {
      final product = await productDataSource.getProductWithDiscountById(
          idproduct: idproduct);
      if (product == null) {
        return null;
      }
      return product;
    } catch (e) {
      print('Error get Product With Discount $e');
      return null;
    }
  }

  @override
  Stream<List<Product>> getProductsStream() {
    return productDataSource.getProductsStream();
  }

  @override
  Future<List<Product>> searchProducts(String textSearch) async {
    final searchProducts = await productDataSource.searchProducts(textSearch);
    return searchProducts;
  }

  @override
  Stream<List<Product>> searchProductsStrean(String textSearch) {
    final searchProducts = productDataSource.searchProductsStrean(textSearch);
    return searchProducts;
  }

  @override
  Future<List<Product>> getProductsByInventory(int idInventory) {
    final response = productDataSource.getProductsByInventory(idInventory);
    return response;
  }

  @override
  Future<List<Product>> getProductsByCompany(String idCompany) async {
    return await productDataSource.getProductsByCompany(idCompany);
  }
}

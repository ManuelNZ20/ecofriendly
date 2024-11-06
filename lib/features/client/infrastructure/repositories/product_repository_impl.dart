import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/datasources/datasources.dart';
import '../../domain/entities/product_client.dart';
import '../../domain/repositories/repositories.dart';
import '../datasources/datasources.dart';

class ProductClientRepositoryImpl implements ProductClientRepository {
  final ProductClientDatasource productDataSource;
  final SupabaseClient supabaseClient;

  ProductClientRepositoryImpl({
    ProductClientDatasource? productDataSource,
    required this.supabaseClient,
  }) : productDataSource = productDataSource ??
            ProductClientDatasourceImpl(
              supabaseClientDatasource: supabaseClient,
            );

  @override
  Future<int> getAmountProducts() async {
    return await productDataSource.getAmountProducts();
  }

  @override
  Future<ProductClient> getProductById({int idProduct = 0}) async {
    final product =
        await productDataSource.getProductById(idProduct: idProduct);
    return product;
  }

  @override
  Future<List<ProductClient>> getProducts() async {
    return await productDataSource.getProducts();
  }

  @override
  Future<List<ProductClient>> getProductsOutstanding() async {
    return await productDataSource.getProductsOutstanding();
  }

  @override
  Future<ProductClient?> getProductWithDiscountById({int idproduct = 0}) async {
    try {
      final product = await productDataSource.getProductWithDiscountById(
          idproduct: idproduct);
      if (product == null) {
        return null;
      }
      return product;
    } catch (e) {
      return null;
    }
  }

  @override
  Stream<List<ProductClient>> getProductsStream() {
    return productDataSource.getProductsStream();
  }

  @override
  Future<List<ProductClient>> searchProducts(String textSearch) async {
    final searchProducts = await productDataSource.searchProducts(textSearch);
    return searchProducts;
  }

  @override
  Stream<List<ProductClient>> searchProductsStream(String textSearch) {
    final searchProducts = productDataSource.searchProductsStream(textSearch);
    return searchProducts;
  }

  @override
  Future<List<ProductClient>> getProductsByCategory(String idCategory) async {
    final products = await productDataSource.getProductsByCategory(idCategory);
    return products;
  }

  @override
  Future<List<ProductClient>> getProductsWithDiscount() async {
    final products = await productDataSource.getProductsWithDiscount();
    return products;
  }
}

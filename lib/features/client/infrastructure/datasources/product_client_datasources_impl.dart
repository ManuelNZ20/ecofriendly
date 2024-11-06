import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/datasources/datasources.dart';
import '../../domain/entities/product_client.dart';
import '../mappers/product_mapper.dart';
import '../model/product_client_model.dart';

class ProductClientDatasourceImpl implements ProductClientDatasource {
  final SupabaseClient supabaseClient;
  static String nameTable = 'product';
  ProductClientDatasourceImpl({
    SupabaseClient? supabaseClientDatasource,
  }) : supabaseClient = supabaseClientDatasource ?? Supabase.instance.client;

  @override
  Stream<List<ProductClient>> getProductsStream() {
    final response = supabaseClient.from(nameTable).stream(primaryKey: ['id']);
    final products = response.map((event) => _responseProduct(event));
    return products;
  }

  @override
  Future<ProductClient> getProductById({int idProduct = 0}) async {
    try {
      final response = await supabaseClient.from(nameTable).select('''
        *,
        productdiscount(*)
        ''').eq('id', idProduct);
      final product = _responseProduct(response).first;
      return product;
    } on AuthException catch (e) {
      if (e.statusCode == '404') {
        throw Exception('ProductClient Not Found');
      }
      throw Exception(e);
    } catch (e) {
      throw Exception('Error loading product, product: $e');
    }
  }

  @override
  Future<int> getAmountProducts() async {
    try {
      final response = await supabaseClient
          .from(nameTable)
          .select()
          .count(CountOption.exact);
      return response.count;
    } catch (e) {
      throw Exception('Error loading products $e');
    }
  }

  @override
  Future<List<ProductClient>> getProducts() async {
    try {
      final response = await supabaseClient.from(nameTable).select('''
        *,
        productdiscount(*)
        ''');
      final products = _responseProduct(response);
      return products;
    } catch (e) {
      throw Exception('Error loading products ${e.toString()}');
    }
  }

  @override
  Future<List<ProductClient>> getProductsOutstanding() async {
    try {
      final response = await supabaseClient.from(nameTable).select();
      final products = _responseProduct(response);
      return products;
    } catch (e) {
      throw Exception('Error loading products ${e.toString()}');
    }
  }

  @override
  Future<ProductClient?> getProductWithDiscountById({int idproduct = 0}) async {
    try {
      final response = await supabaseClient
          .from('productdiscount')
          .select()
          .eq('idproduct', idproduct);
      if (response.isEmpty) {
        return null;
      }
      final product = _responseProduct(response).first;
      return product;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<ProductClient>> searchProducts(String textSearch) async {
    if (textSearch.isEmpty) return [];
    try {
      final response = await supabaseClient
          .from(nameTable)
          .select()
          .ilike('nameproduct', '%$textSearch%');
      final products = _responseProduct(response);
      return products;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Stream<List<ProductClient>> searchProductsStream(String textSearch) {
    throw UnimplementedError();
  }

  List<ProductClient> _responseProduct(List<Map<String, dynamic>> response) {
    final products = response
        .map(
          (product) => ProductClientMapper.toProductEntity(
            ProductClientModel.fromJson(product),
          ),
        )
        .toList();
    return products;
  }

  @override
  Future<List<ProductClient>> getProductsByCategory(String idCategory) async {
    try {
      final response = await supabaseClient
          .from(nameTable)
          .select()
          .eq('idcategory', idCategory);
      final products = _responseProduct(response);
      return products;
    } catch (e) {
      throw Exception('Error loading products ${e.toString()}');
    }
  }

  @override
  Future<List<ProductClient>> getProductsWithDiscount() async {
    try {
      final response = await supabaseClient.from(nameTable).select('''
        *,
        productdiscount(*)
        ''').neq('productdiscount', []);
      final products = _responseProduct(response);
      return products;
    } catch (e) {
      throw Exception('Error loading products ${e.toString()}');
    }
  }
}

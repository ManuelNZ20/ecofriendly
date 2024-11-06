import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/datasources/datasources.dart';
import '../../domain/entities/entities.dart';
import '../mappers/product_discount_client_mapper.dart';
import '../model/product_discount_client_model.dart';

class ProductDiscountClientDataSourceImpl
    extends ProductDiscountClientDatasource {
  final SupabaseClient supabaseClient;
  static String nameTable = 'productdiscount';

  ProductDiscountClientDataSourceImpl({
    SupabaseClient? supabaseClientDatasource,
  }) : supabaseClient = supabaseClientDatasource ?? Supabase.instance.client;
  @override
  Future<List<ProductClientDiscount>> getProductsDiscount() async {
    try {
      final response = await supabaseClient.from(nameTable).select('''
        *,
        product(*)
        ''');
      final productsDiscount = _responseProductDiscount(response);
      return productsDiscount;
    } on AuthException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ProductClientDiscount?> getProductDiscountById(
      {String idproduct = ''}) async {
    try {
      final response = await supabaseClient.from(nameTable).select('''
              *,
              product(*)
            ''').eq('idproduct', idproduct);
      final productDiscount = _responseProductDiscount(response).first;
      return productDiscount;
    } on AuthException catch (e) {
      if (e.statusCode == '404') {
        throw Exception('ProductClientDiscount Not Found');
      }
      throw Exception(e);
    } catch (e) {
      return null;
    }
  }

  @override
  Stream<List<ProductClientDiscount>> getProductsDiscountStream() {
    try {
      final response = supabaseClient
          .from(nameTable)
          .stream(primaryKey: ['idproductdiscount']);
      final productsDiscount =
          response.map((event) => _responseProductDiscount(event));
      return productsDiscount;
    } catch (e) {
      throw Exception(e);
    }
  }

  List<ProductClientDiscount> _responseProductDiscount(
      List<Map<String, dynamic>> response) {
    final productsDiscount = response
        .map((e) => ProductDiscountClientMapper.toProductEntity(
            ProductDiscountClientModel.fromJson(e)))
        .toList();
    return productsDiscount;
  }
}

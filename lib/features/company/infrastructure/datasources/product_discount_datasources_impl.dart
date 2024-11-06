import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/domain.dart';
import '../mapper/product_discount_mapper.dart';
import '../models/product_discount.module.dart';

class ProductDiscountDataSourceImpl extends ProductDiscountDatasource {
  final SupabaseClient supabaseClient;
  static String nameTable = 'productdiscount';

  ProductDiscountDataSourceImpl({
    SupabaseClient? supabaseClientDatasource,
  }) : supabaseClient = supabaseClientDatasource ?? Supabase.instance.client;
  @override
  Future<List<ProductDiscount>> getProductsDiscount() async {
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
  Future<ProductDiscount> createProductDiscount({
    int idproduct = 0,
    double discountPercentage = 0.0,
  }) async {
    try {
      final response = await supabaseClient.from(nameTable).insert([
        {
          'id_ext': idproduct,
          'discount_percentage': discountPercentage,
        }
      ]).select('''
          *, product(*)
      ''');
      final productsDiscount = _responseProductDiscount(response).first;
      return productsDiscount;
    } catch (e) {
      print('Created Product $e');
      throw Exception(e);
    }
  }

  @override
  Future<ProductDiscount?> getProductDiscountById({int idproduct = 0}) async {
    try {
      final response = await supabaseClient.from(nameTable).select('''
              *,
              product(*)
            ''').eq('id_ext', idproduct);
      final productDiscount = _responseProductDiscount(response).first;
      return productDiscount;
    } on AuthException catch (e) {
      if (e.statusCode == '404') {
        throw Exception('ProductDiscount Not Found');
      }
      throw Exception(e);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<ProductDiscount> updateProductDiscount({
    String idproductdiscount = '',
    int idproduct = 0,
    double discountPercentage = 0.0,
  }) async {
    try {
      final response = await supabaseClient
          .from(nameTable)
          .update({
            // 'idproduct': idproduct,
            'discount_percentage': discountPercentage,
          })
          .eq(
            'idproductdiscount',
            idproductdiscount,
          )
          .select('''
              *,
              product(*)
            ''');
      final productDiscount = _responseProductDiscount(response).first;
      return productDiscount;
    } catch (e) {
      print('Error update product discount: $e');
      throw Exception(e);
    }
  }

  @override
  Stream<List<ProductDiscount>> getProductsStream() {
    try {
      final response = supabaseClient
          .from(nameTable)
          .stream(primaryKey: ['idproductdiscount']);
      final productsDiscount =
          response.map((event) => _responseProductDiscount(event));
      return productsDiscount;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  List<ProductDiscount> _responseProductDiscount(
      List<Map<String, dynamic>> response) {
    final productsDiscount = response
        .map((e) => ProductDiscountMapper.toProductEntity(
            ProductDiscountModel.fromJson(e)))
        .toList();
    return productsDiscount;
  }
}

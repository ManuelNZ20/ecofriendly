import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/datasources/datasources.dart';
import '../../domain/entities/product_discount_client.dart';
import '../../domain/repositories/repositories.dart';
import '../datasources/datasources.dart';

class ProductDiscountClientRepositoryImpl
    extends ProductDiscountClientRepository {
  final ProductDiscountClientDatasource productDiscountDatasource;
  final SupabaseClient supabaseClient;

  ProductDiscountClientRepositoryImpl({
    ProductDiscountClientDatasource? productDiscountDatasource,
    required this.supabaseClient,
  }) : productDiscountDatasource = productDiscountDatasource ??
            ProductDiscountClientDataSourceImpl(
              supabaseClientDatasource: supabaseClient,
            );
  @override
  Future<List<ProductClientDiscount>> getProductsDiscount() async {
    return await productDiscountDatasource.getProductsDiscount();
  }

  @override
  @override
  Future<ProductClientDiscount?> getProductDiscountById(
      {String idproduct = ''}) async {
    try {
      final productdiscount = await productDiscountDatasource
          .getProductDiscountById(idproduct: idproduct);
      return productdiscount;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Stream<List<ProductClientDiscount>> getProductsDiscountStream() {
    return productDiscountDatasource.getProductsDiscountStream();
  }
}

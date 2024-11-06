import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/domain.dart';
import '../datasources/product_discount_datasources_impl.dart';

class ProductDiscountRepositoryImpl extends ProductDiscountRepository {
  final ProductDiscountDatasource productDiscountDatasource;
  final SupabaseClient supabaseClient;

  ProductDiscountRepositoryImpl({
    ProductDiscountDatasource? productDiscountDatasource,
    required this.supabaseClient,
  }) : productDiscountDatasource = productDiscountDatasource ??
            ProductDiscountDataSourceImpl(
              supabaseClientDatasource: supabaseClient,
            );
  @override
  Future<List<ProductDiscount>> getProductsDiscount() async {
    return await productDiscountDatasource.getProductsDiscount();
  }

  @override
  Future<ProductDiscount> createProductDiscount({
    int idproduct = 0,
    double discountPercentage = 0.0,
  }) async {
    try {
      return await productDiscountDatasource.createProductDiscount(
        idproduct: idproduct,
        discountPercentage: discountPercentage,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  @override
  Future<ProductDiscount?> getProductDiscountById({int idproduct = 0}) async {
    try {
      final productdiscount = await productDiscountDatasource
          .getProductDiscountById(idproduct: idproduct);
      return productdiscount;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ProductDiscount> updateProductDiscount({
    String idproductdiscount = '',
    int idproduct = 0,
    double discountPercentage = .0,
  }) async {
    try {
      final productDiscount =
          await productDiscountDatasource.updateProductDiscount(
        idproductdiscount: idproductdiscount,
        idproduct: idproduct,
        discountPercentage: discountPercentage,
      );
      return productDiscount;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Stream<List<ProductDiscount>> getProductsStream() {
    return productDiscountDatasource.getProductsStream();
  }
}

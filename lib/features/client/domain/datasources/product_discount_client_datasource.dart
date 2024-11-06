import '../entities/entities.dart';

abstract class ProductDiscountClientDatasource {
  Future<List<ProductClientDiscount>> getProductsDiscount();

  Future<ProductClientDiscount?> getProductDiscountById({
    String idproduct = '',
  });
  Stream<List<ProductClientDiscount>> getProductsDiscountStream();
}

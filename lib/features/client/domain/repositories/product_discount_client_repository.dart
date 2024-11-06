import '../entities/entities.dart';

abstract class ProductDiscountClientRepository {
  Future<List<ProductClientDiscount>> getProductsDiscount();

  Future<ProductClientDiscount?> getProductDiscountById({
    String idproduct = '',
  });
  Stream<List<ProductClientDiscount>> getProductsDiscountStream();
}

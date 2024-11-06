import '../entities/product_discount.dart';

abstract class ProductDiscountDatasource {
  Future<List<ProductDiscount>> getProductsDiscount();

  Future<ProductDiscount?> getProductDiscountById({
    int idproduct = 0,
  });

  Future<ProductDiscount> createProductDiscount({
    int idproduct,
    double discountPercentage,
  });

  Future<ProductDiscount> updateProductDiscount({
    String idproductdiscount,
    int idproduct,
    double discountPercentage,
  });
  Stream<List<ProductDiscount>> getProductsStream();
}

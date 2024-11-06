import '../../domain/entities/entities.dart';
import '../model/product_discount_client_model.dart';

class ProductDiscountClientMapper {
  static ProductClientDiscount toProductEntity(
          ProductDiscountClientModel productDiscount) =>
      ProductClientDiscount(
        idproductdiscount: productDiscount.idproductdiscount,
        idproduct: productDiscount.idproduct,
        discountpercentage: productDiscount.discountPercentage,
        createdAt: productDiscount.createdAt,
      );
}

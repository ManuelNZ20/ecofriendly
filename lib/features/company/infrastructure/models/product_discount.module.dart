import '../../domain/domain.dart';
import '../mapper/product_mapper.dart';
import 'product.module.dart';

class ProductDiscountModel {
  final String idproductdiscount;
  final int idproduct;
  final double discountPercentage;
  final DateTime createdAt;
  final Product product;

  ProductDiscountModel({
    required this.idproductdiscount,
    required this.idproduct,
    required this.discountPercentage,
    required this.createdAt,
    required this.product,
  });

  factory ProductDiscountModel.fromJson(Map<String, dynamic> json) =>
      ProductDiscountModel(
        idproductdiscount: json["idproductdiscount"],
        idproduct: json["id_ext"],
        discountPercentage:
            double.parse(json["discount_percentage"].toString()),
        createdAt: DateTime.parse(json["created_at"]),
        product: ProductMapper.toProductEntity(
            ProductModel.fromJson(json['product'])),
      );
}

import '../../domain/entities/entities.dart';
import '../mappers/product_discount_client_mapper.dart';
import 'product_discount_client_model.dart';

class ProductClientModel {
  final int id;
  final String idproduct;
  final String nameproduct;
  final String brand;
  final String description;
  final bool status;
  final String imgproduct;
  final double price;
  final int amount;
  final DateTime createAt;
  final DateTime updateAt;
  final DateTime expireProduct;
  final int idcategory;
  // final List<ProductClientDiscount> productdiscount;
  final String idproductdiscount;
  final double discountpercentage; //discount_percentage

  ProductClientModel({
    required this.id,
    required this.idproduct,
    required this.nameproduct,
    required this.brand,
    required this.description,
    required this.status,
    required this.imgproduct,
    required this.price,
    required this.amount,
    required this.createAt,
    required this.updateAt,
    required this.expireProduct,
    required this.idcategory,
    required this.idproductdiscount,
    required this.discountpercentage,
  });

  factory ProductClientModel.fromJson(Map<String, dynamic> json) {
    final productDiscountJson = json['productdiscount'];
    List<ProductClientDiscount> productDiscountList = <ProductClientDiscount>[];

    if (productDiscountJson != null && productDiscountJson.isNotEmpty) {
      productDiscountList = List<ProductClientDiscount>.from(
        productDiscountJson.map((x) {
          if (x != null) {
            return ProductDiscountClientMapper.toProductEntity(
              ProductDiscountClientModel.fromJson(x),
            );
          } else {
            return null; // or handle the null case if needed
          }
        }).where((element) => element != null), // Remove nulls if any
      );
    }

    return ProductClientModel(
      id: json['id_ext'],
      idproduct: json["idproduct"],
      nameproduct: json["nameproduct"],
      brand: json["brand"],
      description: json["description"],
      status: json["statusproduct"],
      imgproduct: json["imgproduct"],
      price: double.parse(json["price"].toString()),
      amount: int.parse(json["amount"].toString()),
      createAt: DateTime.parse(json["create_at"] ?? DateTime.now().toString()),
      updateAt: DateTime.parse(json["update_at"] ?? DateTime.now().toString()),
      expireProduct:
          DateTime.parse(json["expire_product"] ?? DateTime.now().toString()),
      idcategory: json["idcategory"],
      idproductdiscount: productDiscountList.isEmpty
          ? ''
          : productDiscountList.first.idproductdiscount,
      discountpercentage: productDiscountList.isEmpty
          ? 0.0
          : productDiscountList.first.discountpercentage,
    );
  }
}

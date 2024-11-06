class ProductDiscountClientModel {
  final String idproductdiscount;
  final int idproduct;
  final double discountPercentage;
  final DateTime createdAt;

  ProductDiscountClientModel({
    required this.idproductdiscount,
    required this.idproduct,
    required this.discountPercentage,
    required this.createdAt,
  });

  factory ProductDiscountClientModel.fromJson(Map<String, dynamic> json) =>
      ProductDiscountClientModel(
        idproductdiscount: json["idproductdiscount"],
        idproduct: json["id_ext"],
        discountPercentage:
            double.parse(json["discount_percentage"].toString()),
        createdAt: DateTime.parse(json["created_at"]),
      );
}

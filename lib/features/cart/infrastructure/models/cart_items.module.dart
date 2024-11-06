class CartItemsModel {
  final int id;
  final String userId;
  final int productId;
  final String nameProduct;
  final double price;
  final int quantity;

  CartItemsModel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.nameProduct,
    required this.price,
    required this.quantity,
  });
  factory CartItemsModel.fromJson(Map<String, dynamic> json) => CartItemsModel(
        id: json['id_cart'] ?? 0,
        userId: json['user_id'] ?? '',
        productId: json['product_id'] ?? 0,
        nameProduct: json['name_product'] ?? '',
        price: (json['price'] as num?)?.toDouble() ?? 0.0,
        quantity: json['quantity'] ?? 0,
      );
  CartItemsModel copyWith({
    int? id,
    String? userId,
    int? productId,
    String? nameProduct,
    double? price,
    int? quantity,
  }) =>
      CartItemsModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        productId: productId ?? this.productId,
        nameProduct: nameProduct ?? this.nameProduct,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
      );
}

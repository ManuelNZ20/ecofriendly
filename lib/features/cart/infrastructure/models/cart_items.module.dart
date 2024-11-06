class CartItemsModel {
  final int id;
  final String userId;
  final int productId;
  final double price;
  final int quantity;

  CartItemsModel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.price,
    required this.quantity,
  });
  factory CartItemsModel.fromJson(Map<String, dynamic> json) => CartItemsModel(
        id: json['id_cart'] ?? 0,
        userId: json['user_id'] ?? '',
        productId: json['product_id'] ?? 0,
        price: json['price'] ?? 0,
        quantity: json['quantity'] ?? 0.0,
      );
  CartItemsModel copyWith({
    int? id,
    String? userId,
    int? productId,
    double? price,
    int? quantity,
  }) =>
      CartItemsModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        productId: productId ?? this.productId,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
      );
}

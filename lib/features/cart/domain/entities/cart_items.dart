class CartItems {
  final int id;
  final String userId;
  final int productId;
  final String nameProduct;
  final double price;
  final int quantity;

  CartItems({
    required this.id,
    required this.userId,
    required this.productId,
    required this.nameProduct,
    required this.price,
    required this.quantity,
  });
  CartItems copyWith({
    int? id,
    String? userId,
    int? productId,
    String? nameProduct,
    double? price,
    int? quantity,
  }) =>
      CartItems(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        productId: productId ?? this.productId,
        nameProduct: nameProduct ?? this.nameProduct,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
      );
}

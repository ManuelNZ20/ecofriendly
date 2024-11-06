class OrderItem {
  final int id;
  final int orderId;
  final int productId;
  final int quantity;
  final double price;
  final String createAt;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.createAt,
  });

  OrderItem copyWith({
    int? id,
    int? orderId,
    int? productId,
    int? quantity,
    double? price,
    String? createAt,
  }) =>
      OrderItem(
        id: id ?? this.id,
        orderId: orderId ?? this.orderId,
        productId: productId ?? this.productId,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
        createAt: createAt ?? this.createAt,
      );
}

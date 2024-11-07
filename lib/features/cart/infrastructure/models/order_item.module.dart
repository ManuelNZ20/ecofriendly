class OrderItemModel {
  final int id;
  final int orderId;
  final int productId;
  final int quantity;
  final double price;
  final String createAt;

  OrderItemModel({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.createAt,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => OrderItemModel(
        id: json['id'] ?? 0,
        orderId: json['order_id'] ?? 0,
        productId: json['product_id'] ?? 0,
        quantity: json['quantity'] ?? 0,
        price: (json['price'] as num?)?.toDouble() ?? 0.0,
        createAt: json['created_at'] ?? '',
      );
}

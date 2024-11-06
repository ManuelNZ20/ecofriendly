class OrderModel {
  final int id;
  final String userId;
  final double totalPrice;
  final String status;
  final DateTime createAt;

  OrderModel({
    required this.id,
    required this.userId,
    required this.totalPrice,
    required this.status,
    required this.createAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json['id'] ?? 0,
        userId: json['user_id'] ?? '',
        totalPrice: json['total_price'] ?? 0.0,
        status: json['status'] ?? '',
        createAt: json['create_at'],
      );
}

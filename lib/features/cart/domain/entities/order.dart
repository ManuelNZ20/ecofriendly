class Order {
  final int id;
  final String userId;
  final double totalPrice;
  final String status;
  final DateTime createAt;

  Order({
    required this.id,
    required this.userId,
    required this.totalPrice,
    required this.status,
    required this.createAt,
  });

  Order copyWith({
    int? id,
    String? userId,
    double? totalPrice,
    String? status,
    DateTime? createAt,
  }) =>
      Order(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        totalPrice: totalPrice ?? this.totalPrice,
        status: status ?? this.status,
        createAt: createAt ?? this.createAt,
      );
}

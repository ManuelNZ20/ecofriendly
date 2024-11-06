class CartItems {
  final int id;
  final String userId;
  final int productId;
  final double price;
  final int quantity;

  CartItems({
    required this.id,
    required this.userId,
    required this.productId,
    required this.price,
    required this.quantity,
  });
}

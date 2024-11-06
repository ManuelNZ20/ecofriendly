import '../entities/order.dart';
import '../entities/order_item.dart';

abstract class OrderDatasource {
  Future<Order> createOrder(
      List<OrderItem> items, String userId, double totalPrice);
  Future<List<Order>> getOrdersByUser(String userId);

  Future<void> updateOrderStatus(int orderId, String status);
}

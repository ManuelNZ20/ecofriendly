import '../../domain/domain.dart';

class OrderRepositoryImpl extends OrderRepository {
  final OrderDatasource datasource;

  OrderRepositoryImpl(this.datasource);
  @override
  Future<Order> createOrder(
      List<OrderItem> items, String userId, double totalPrice) async {
    return await datasource.createOrder(
      items,
      userId,
      totalPrice,
    );
  }

  @override
  Future<List<Order>> getOrdersByUser(String userId) async {
    return await datasource.getOrdersByUser(
      userId,
    );
  }

  @override
  Future<void> updateOrderStatus(int orderId, String status) async {
    return await datasource.updateOrderStatus(
      orderId,
      status,
    );
  }
}

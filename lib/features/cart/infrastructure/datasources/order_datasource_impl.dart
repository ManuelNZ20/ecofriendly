import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/domain.dart';
import '../infrastructure.dart';

class OrderDatasourceImpl extends OrderDatasource {
  final supabase = Supabase.instance.client;
  @override
  Future<Order> createOrder(
      List<OrderItem> items, String userId, double totalPrice) async {
    try {
      final response = await supabase
          .from('orders')
          .insert({
            'user_id': userId,
            'total_price': totalPrice,
            'status': 'PENDIENTE',
          })
          .select()
          .single();
      final orderId = response['id_orders'];
      for (final item in items) {
        await supabase.from('orders_items').insert({
          'order_id': orderId,
          'product_id': item.productId,
          'quantity': item.quantity,
          'price': item.price,
        });
      }
      return Order(
        id: orderId,
        userId: userId,
        totalPrice: totalPrice,
        status: 'PENDIENTE',
        createAt: DateTime.parse(response['created_at']),
      );
    } catch (e) {
      print(e);
      throw Exception('Error create order $e');
    }
  }

  @override
  Future<List<Order>> getOrdersByUser(String userId) async {
    try {
      final response =
          await supabase.from('orders').select().eq('user_id', userId);
      final listOrders = response.map((e) => _responseOrder(e)).toList();
      return listOrders;
    } catch (e) {
      print(e);
      throw Exception('Error order by user $e');
    }
  }

  @override
  Future<void> updateOrderStatus(int orderId, String status) async {
    try {
      await supabase.from('orders').update(
        {'status': status},
      ).eq('id_orders', orderId);
    } catch (e) {
      print(e);
      throw Exception('Error update order status $e');
    }
  }

  OrderItem _responseOrderItem(Map<String, dynamic> json) {
    final model = OrderItemModel.fromJson(json);
    final orderItem = OrderItemMapper.toOrderItemEntity(model);
    return orderItem;
  }

  Order _responseOrder(Map<String, dynamic> json) {
    final model = OrderModel.fromJson(json);
    final order = OrderMapper.toOrderEntity(model);
    return order;
  }
}

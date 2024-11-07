import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/domain.dart';
import '../../infrastructure/infrastructure.dart';

final ordersItemProvider =
    StateNotifierProvider.family<OrderItemNotifier, List<OrderItem>, int>(
        (ref, orderId) {
  return OrderItemNotifier(orderId: orderId);
});

class OrderItemNotifier extends StateNotifier<List<OrderItem>> {
  final supabase = Supabase.instance.client;

  OrderItemNotifier({
    required int orderId,
  }) : super([]) {
    loadOrderItems(orderId);
  }

  Future<void> loadOrderItems(int orderId) async {
    final response =
        await supabase.from('orders_items').select().eq('order_id', orderId);
    final listOrderItems = response.map((e) => _responseOrderItem(e)).toList();
    state = listOrderItems;
  }

  OrderItem _responseOrderItem(Map<String, dynamic> json) {
    final model = OrderItemModel.fromJson(json);
    final orderItem = OrderItemMapper.toOrderItemEntity(model);
    return orderItem;
  }
}

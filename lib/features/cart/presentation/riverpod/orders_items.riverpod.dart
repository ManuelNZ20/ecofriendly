import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/domain.dart';
import '../../infrastructure/infrastructure.dart';

final ordersItemProvider =
    StateNotifierProvider.family<OrderItemNotifier, List<StateOrderItem>, int>(
        (ref, orderId) {
  return OrderItemNotifier(orderId: orderId);
});

class OrderItemNotifier extends StateNotifier<List<StateOrderItem>> {
  final supabase = Supabase.instance.client;

  OrderItemNotifier({
    required int orderId,
  }) : super([]) {
    loadOrderItems(orderId);
  }

  Future<void> loadOrderItems(int orderId) async {
    final response = await supabase.from('orders_items').select('''
          id,
          order_id,
          product_id,
          quantity,
          price,
          product(
            nameproduct,
            imgproduct
          )
        ''').eq('order_id', orderId);
    // final listOrderItems = response.map((e) => _responseOrderItem(e)).toList();
    final listStateOrderItems =
        response.map((e) => _responseStateOrderItem(e)).toList();
    state = listStateOrderItems;
  }

  OrderItem _responseOrderItem(Map<String, dynamic> json) {
    final model = OrderItemModel.fromJson(json);
    final orderItem = OrderItemMapper.toOrderItemEntity(model);
    return orderItem;
  }

  StateOrderItem _responseStateOrderItem(Map<String, dynamic> json) {
    return StateOrderItem(
      idOrderItem: json['id'],
      orderId: json['order_id'],
      productId: json['product_id'],
      nameProduct: json['product']['nameproduct'],
      imgProduct: json['product']['imgproduct'],
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      quantity: json['quantity'],
    );
  }
}

class StateOrderItem {
  final int idOrderItem;
  final int orderId;
  final int productId;
  final String nameProduct;
  final String imgProduct;
  final double price;
  final int quantity;

  StateOrderItem({
    required this.idOrderItem,
    required this.orderId,
    required this.productId,
    required this.nameProduct,
    required this.imgProduct,
    required this.price,
    required this.quantity,
  });

  StateOrderItem copyWith({
    int? idOrderItem,
    int? orderId,
    int? productId,
    String? nameProduct,
    String? imgProduct,
    double? price,
    int? quantity,
  }) =>
      StateOrderItem(
        idOrderItem: idOrderItem ?? this.idOrderItem,
        orderId: orderId ?? this.orderId,
        productId: productId ?? this.productId,
        nameProduct: nameProduct ?? this.nameProduct,
        imgProduct: imgProduct ?? this.imgProduct,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
      );
}

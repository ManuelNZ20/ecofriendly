import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/shared/infrastructure/service/supabase_cliente_provider.riverpod.dart';
import '../../domain/domain.dart';

final ordersProvider =
    StateNotifierProvider<OrdersNotifier, OrdersState>((ref) {
  final supabaseClient = ref.watch(supabaseProvider);
  return OrdersNotifier(supabase: supabaseClient);
});

class OrdersNotifier extends StateNotifier<OrdersState> {
  final SupabaseClient supabase;

  OrdersNotifier({required this.supabase})
      : super(
          OrdersState(),
        ) {
    loadOrders();
  }

  Future<void> loadOrders() async {
    try {
      state = state.copyWith(orders: []);
      if (state.isLoading) return;
      state = state.copyWith(isLoading: true);
      final response = await supabase.from('orderbuy').select();
      final orders = response
          .map(
            (order) => OrderBuy(
              idlastorderbuy: order['idlastorderbuy'],
              idorderbuy: order['idorderbuy'],
              dateorder: order['dateorder'],
              datedelivery: order['datedelivery'] ?? '',
              dateconfirm: order['dateconfirm'] ?? '',
              stateorder: order['stateorder'],
              total: double.parse(order['total'].toString()),
              idpaymentmethod: order['idpaymentmethod'].toString(),
            ),
          )
          .toList();
      if (orders.isEmpty) {
        state = state.copyWith(isLoading: false);
        return;
      }
      state = state.copyWith(
        isLoading: false,
        orders: orders,
      );
    } catch (e) {
      print('Error: $e');
      state = state.copyWith(
        isLoading: false,
        hasError: true,
      );
    }
  }
}

class OrdersState {
  final List<OrderBuy> orders;
  final bool isLoading;
  final bool hasError;

  OrdersState({
    this.orders = const [],
    this.isLoading = false,
    this.hasError = false,
  });

  OrdersState copyWith({
    List<OrderBuy>? orders,
    bool? isLoading,
    bool? hasError,
  }) {
    return OrdersState(
      orders: orders ?? this.orders,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }
}

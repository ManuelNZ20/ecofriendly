import 'package:ecofriendly_flutter_app/features/cart/presentation/riverpod/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/widgets.dart';

class OrdersView extends ConsumerWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(ordersNotifierProvider);
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.shopping_bag_outlined,
          color: colors.primary,
        ),
        title: const Text('Ordenes'),
      ),
      body: orders.isEmpty
          ? const MessageEmptyListOrders()
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return OrderItemOrders(
                  order: order,
                );
              },
            ),
    );
  }
}

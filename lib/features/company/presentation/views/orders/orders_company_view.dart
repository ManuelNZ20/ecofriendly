import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/orders.riverpod.dart';

class OrderCompanyView extends ConsumerWidget {
  const OrderCompanyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderByCompany = ref.watch(ordersByCompanyFromUsersProvider);
    final size = MediaQuery.of(context).size;
    return orderByCompany.when(
      data: (data) {
        if (data.isEmpty) {
          return const Center(
            child: Text('No cuenta con Ordenes '),
          );
        }
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final order = data[index];
            return InkWell(
              onTap: () {},
              child: Container(
                width: size.width,
                padding: const EdgeInsets.all(10),
                height: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.circle_notifications_outlined),
                    const SizedBox(height: 10),
                    Text('${order['user_app']['email']}'),
                    const SizedBox(height: 10),
                    ...order['orders_items'].map(
                      (item) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Precio ${item['price']}',
                            ),
                            Text('Cantidad ${item['quantity']}')
                          ],
                        );
                      },
                    ),
                    const Spacer(),
                    Text('Total ${order['total_price']}'),
                    Text('Total ${order['status']}'),
                    const Divider(),
                  ],
                ),
              ),
            );
          },
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Text('Error $error'),
        );
      },
      loading: () {
        return const Center(
          child: Text('Sin datos'),
        );
      },
    );
  }
}

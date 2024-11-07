import 'package:ecofriendly_flutter_app/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/shared/shared.dart';
import '../riverpod/providers.dart';
import '../widgets/widgets.dart';

class OrderDetailScreen extends ConsumerWidget {
  static const String name = 'order_detail_screen';
  const OrderDetailScreen({
    super.key,
    required this.orderId,
  });

  final int orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref
        .watch(ordersNotifierProvider)
        .where((element) => element.id == orderId)
        .toList()
        .first;
    final ordersItems = ref.watch(ordersItemProvider(orderId));
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    final title = Theme.of(context).textTheme.titleLarge;

    return Scaffold(
      appBar: AppBar(
        leading: const IconButtonArrowBack(),
        title: Text('Orden #$orderId'),
        actions: [
          TagStateOrder(stateOrder: orders.status),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: SizedBox(
              width: size.width,
              height: size.height * .68,
              child: ListView.builder(
                itemCount: ordersItems.length,
                itemBuilder: (context, index) {
                  final orderItem = ordersItems[index];
                  return ListTileOrderItem(
                    orderItem: orderItem,
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: size.width,
              height: size.height * .2,
              child: Container(
                width: size.width,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                  color: colors.background,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'TOTAL',
                          style: title,
                        ),
                        Text(
                          orders.totalPrice.toStringAsFixed(3),
                          style: title!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: size.width,
                      child: FilledButton.icon(
                        onPressed: () =>
                            showConfirmationDialog(context, ref, orderId),
                        icon: const Icon(Icons.payment_rounded),
                        label: Text(
                          'REALIZAR PAGO',
                          style: title.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: colors.background,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

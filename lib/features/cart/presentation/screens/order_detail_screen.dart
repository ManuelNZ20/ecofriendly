import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/shared/shared.dart';
import '../riverpod/stripe.riverpod.dart';
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
              height: size.height * .6,
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
              height: size.height * .3,
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
                    Text(
                      'TOTAL A PAGAR',
                      style: title!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'SOLES',
                          style: title,
                        ),
                        Text(
                          'S/. ${orders.totalPrice.toStringAsFixed(3)}',
                          style: title,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "DOLARES",
                          style: title,
                        ),
                        Text(
                          "\$ ${(orders.totalPrice / 3.77).toStringAsFixed(3)}",
                          style: title,
                        ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      width: size.width,
                      child: FilledButton.icon(
                        onPressed: () async {
                          try {
                            await ref
                                .read(stripeServiceProvider.notifier)
                                .makePayment(orders.totalPrice ~/ 3.77, 'usd');
                            ref
                                .read(ordersNotifierProvider.notifier)
                                .updateOrderStatus(orderId, 'CONFIRMADO');
                          } catch (e) {
                            print('Error $e');
                          }
                        },
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
                    const SizedBox(height: 14),
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

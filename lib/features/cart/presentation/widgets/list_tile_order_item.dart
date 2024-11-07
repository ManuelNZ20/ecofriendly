import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ecofriendly_flutter_app/features/cart/presentation/riverpod/orders_items.riverpod.dart';

import '../../../client/presentation/screens/screens.dart';

class ListTileOrderItem extends StatelessWidget {
  const ListTileOrderItem({
    super.key,
    required this.orderItem,
  });
  final StateOrderItem orderItem;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final title = Theme.of(context).textTheme.bodySmall!.copyWith(
          color: colors.background,
        );
    final titleTotal = Theme.of(context).textTheme.titleMedium!.copyWith();
    final titlePriceTotal = Theme.of(context).textTheme.titleMedium!.copyWith(
          fontSize: 14,
        );
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(orderItem.imgProduct),
      ),
      title: Text(orderItem.nameProduct),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Precio S/. ${orderItem.price.toStringAsFixed(2)}'),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: colors.primary,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              'x${orderItem.quantity}',
              style: title,
            ),
          ),
        ],
      ),
      trailing: Column(
        children: [
          Text(
            'Total',
            style: titleTotal,
          ),
          Text(
            (orderItem.price * orderItem.quantity).toStringAsFixed(2),
            style: titlePriceTotal,
          ),
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 6,
      ),
      onTap: () => context.pushNamed(ProductDetailScreen.name, pathParameters: {
        'page': '1',
        'idProduct': '${orderItem.productId}',
      }),
    );
  }
}

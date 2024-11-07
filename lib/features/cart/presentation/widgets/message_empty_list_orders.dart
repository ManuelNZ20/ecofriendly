import 'package:flutter/material.dart';

class MessageEmptyListOrders extends StatelessWidget {
  const MessageEmptyListOrders({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final title = Theme.of(context).textTheme.bodyLarge!.copyWith();
    final colors = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_checkout_rounded,
            color: colors.primary,
            size: 70,
          ),
          const SizedBox(height: 20),
          Text(
            'No hay órdenes registradas',
            style: title,
          ),
        ],
      ),
    );
  }
}

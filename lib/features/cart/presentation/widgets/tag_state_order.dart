import 'package:flutter/material.dart';

class TagStateOrder extends StatelessWidget {
  const TagStateOrder({
    super.key,
    required this.stateOrder,
  });
  final String stateOrder;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final labelTag = Theme.of(context).textTheme.bodySmall!.copyWith(
          color: colors.background,
          fontSize: 10,
        );
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: stateOrder == 'PENDIENTE'
            ? Colors.amber.shade600
            : stateOrder != 'CANCELADO'
                ? Colors.teal.shade400
                : colors.error,
        borderRadius: const BorderRadius.all(Radius.circular(50)),
      ),
      child: Text(
        stateOrder.toUpperCase(),
        style: labelTag,
      ),
    );
  }
}

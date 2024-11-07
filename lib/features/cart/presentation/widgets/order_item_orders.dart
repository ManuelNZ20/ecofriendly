import 'package:flutter/material.dart';

import '../../domain/domain.dart';

class OrderItemOrders extends StatelessWidget {
  const OrderItemOrders({
    super.key,
    required this.order,
  });
  final Order order;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    final title = Theme.of(context).textTheme.bodyLarge;
    final labelTag = Theme.of(context).textTheme.bodySmall!.copyWith(
          color: colors.background,
        );
    final titleDateTime = Theme.of(context).textTheme.bodySmall!.copyWith(
          fontSize: 8,
        );
    return InkWell(
      onTap: () {},
      child: Container(
        width: size.width,
        height: 90,
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    color: colors.primary,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(
                          'Orden #${order.id}',
                          style: title,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: Text(
                          'Precio Total S/. ${order.totalPrice.toStringAsFixed(3)}',
                          style: title,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: Text(
                          'Fecha ${order.createAt.toLocal().toString()}',
                          style: titleDateTime,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: order.status == 'PENDIENTE'
                          ? Colors.amber.shade600
                          : Colors.teal.shade400,
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                    ),
                    child: Text(
                      order.status.toUpperCase(),
                      style: labelTag,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Divider()
            ],
          ),
        ),
      ),
    );
  }
}

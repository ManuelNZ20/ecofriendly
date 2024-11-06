import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../client/presentation/screens/screens.dart';
import '../../domain/domain.dart';
import '../riverpod/cart_items.riverpod.dart';

class CartItemProduct extends ConsumerWidget {
  const CartItemProduct({
    super.key,
    required this.cart,
  });

  final CartItems cart;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    final title = Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: 14,
          color: colors.onPrimary,
        );
    return InkWell(
      onTap: () => context.pushNamed(
        ProductDetailScreen.name,
        pathParameters: {
          'idProduct': '${cart.productId}',
          'page': '2',
        },
      ),
      child: SizedBox(
        width: size.width,
        height: 120,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_bag,
                color: colors.primary,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    child: Text(
                      cart.nameProduct,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  Text('Precio ${cart.price}'),
                ],
              ),
              CircleAvatar(
                radius: 15,
                backgroundColor: colors.primary,
                child: Text('${cart.quantity}', style: title),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton.outlined(
                        onPressed: () => ref
                            .read(cartNotifierProvider.notifier)
                            .incrementProductQuantity(cart.productId),
                        icon: const Icon(
                          Icons.plus_one,
                        ),
                      ),
                      IconButton.outlined(
                        onPressed: () => ref
                            .read(cartNotifierProvider.notifier)
                            .decrementProductQuantity(cart.productId),
                        icon: const Icon(
                          Icons.exposure_minus_1,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => ref
                        .read(cartNotifierProvider.notifier)
                        .removeProduct(cart.productId, cart.userId),
                    icon: Icon(
                      Icons.delete_outline_rounded,
                      color: colors.secondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

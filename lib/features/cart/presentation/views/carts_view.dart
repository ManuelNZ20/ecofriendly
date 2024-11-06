import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod/cart_items.riverpod.dart';
import '../widgets/widgets.dart';

class CartView extends ConsumerWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartNotifierProvider);
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    final title = Theme.of(context).textTheme.titleLarge!.copyWith(
          color: colors.onPrimary,
        );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carro de Compras'),
        actions: [
          IconButton(
            onPressed: ref.read(cartNotifierProvider.notifier).clearCart,
            icon: const Icon(Icons.delete_outline_rounded),
          )
        ],
      ),
      body: Stack(
        children: [
          cartItems.isEmpty
              ? const MessageEmptyContent()
              : ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final cart = cartItems[index];
                    return CartItemProduct(
                      cart: cart,
                    );
                  },
                ),
          Positioned(
            bottom: 10,
            child: SizedBox(
              width: size.width,
              height: 80,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                width: size.width * .9,
                decoration: BoxDecoration(
                  color: colors.onBackground,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      ref
                          .read(cartNotifierProvider.notifier)
                          .totalProductsCart()
                          .toStringAsFixed(3),
                      style: title,
                    ),
                    FilledButton(
                      onPressed: () {},
                      child: const Text('Confirmar Orden'),
                    ),
                  ],
                ),
              ),
            ),
          )
          // const _MessageEmptyContent(),
        ],
      ),
    );
  }
}

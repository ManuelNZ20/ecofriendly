import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/functions/show_snackbar.dart';
import '../riverpod/providers.dart';
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
    ref.listen<AsyncValue<bool>>(orderConfirmProvider, (previous, next) {
      next.when(
        data: (data) {
          if (data) {
            showSnackbar(context, 'Orden Confirmada');
          }
          showSnackbar(context, 'Procesando...');
        },
        error: (error, stackTrace) {
          showSnackbar(context, 'Error de Orden: $error');
        },
        loading: () {
          showSnackbar(context, 'Procesando...');
        },
      );
    });
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.shopping_cart_outlined,
          color: colors.primary,
        ),
        title: const Text('Carro de Compras'),
        actions: [
          IconButton(
            onPressed: ref.read(cartNotifierProvider.notifier).clearCart,
            icon: Icon(
              Icons.delete_outline_rounded,
              color: colors.error,
            ),
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
                      onPressed: cartItems.isNotEmpty
                          ? () =>
                              // Llama al proveedor para procesar la orden
                              ref.refresh(orderConfirmProvider)
                          : () => showSnackbar(context, 'Lista Vacía'),
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

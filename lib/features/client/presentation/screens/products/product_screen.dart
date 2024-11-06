import 'package:ecofriendly_flutter_app/features/cart/presentation/riverpod/cart_items.riverpod.dart';
import 'package:ecofriendly_flutter_app/features/client/domain/entities/product_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/shared/shared.dart';
import '../../riverpod/products_provider.dart';
import '../../riverpod/storage/favorite_products.riverpod.dart';
import '../../riverpod/storage/local_storage.riverpod.dart';

class ProductDetailScreen extends ConsumerWidget {
  static const String name = 'product_detail_screen';
  const ProductDetailScreen({
    super.key,
    required this.productId,
  });
  final int productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product =
        ref.watch(productsProvider.notifier).getProduct(id: productId);
    final titleTheme = Theme.of(context).textTheme.bodyLarge!.copyWith(
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        );
    final titlePrice = Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: 30,
          color: Colors.orange,
          overflow: TextOverflow.ellipsis,
        );
    final descriptionStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        );
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leading: const IconButtonArrowBack(),
        title: const Text('Detalles del producto'),
        actions: [
          _SliderAppBar(product: product),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(product.img, width: 200, height: 200,
                  errorBuilder: (context, error, stackTrace) {
                return const SizedBox(
                  width: 200,
                  height: 200,
                  child: Center(
                    child: Text('Failed'),
                  ),
                );
              }, loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return const SizedBox(
                    width: 200,
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              }),
            ),
            const SizedBox(height: 16.0),
            Text(
              product.nameProduct,
              style: titleTheme,
              maxLines: 4,
            ),
            const SizedBox(height: 8.0),
            Text(product.brand.toUpperCase(),
                style: const TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'S/. ${product.discountpercentage != 0 ? (product.price - (product.discountpercentage * product.price)).toStringAsFixed(2) : product.price.toStringAsFixed(2)}',
                      style: titlePrice,
                    ),
                    const SizedBox(width: 14),
                    Text(
                      'S/. ${product.price}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.grey,
                      ),
                    ),
                  ],
                ),
                if (product.discountpercentage != 0.0)
                  Text('-${product.discountpercentage * 100}%',
                      style: const TextStyle(fontSize: 16, color: Colors.red)),
              ],
            ),
            if (product.amount > 0)
              const Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 8.0),
                  Text('Disponible en tienda',
                      style: TextStyle(fontSize: 16, color: Colors.green)),
                ],
              )
            else
              const Row(
                children: [
                  Icon(Icons.error, color: Colors.red),
                  SizedBox(width: 8.0),
                  Text('No disponible',
                      style: TextStyle(fontSize: 16, color: Colors.red)),
                ],
              ),
            const SizedBox(height: 16.0),
            const Row(
              children: [
                Icon(Icons.star, color: Colors.orange),
                SizedBox(width: 4.0),
                Text('3.5', style: TextStyle(fontSize: 16)),
                SizedBox(width: 4.0),
                Text('(192 revisiones)',
                    style: TextStyle(fontSize: 16, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 16.0),
            Text(
              'Descripción',
              style: descriptionStyle,
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .2,
              child: SingleChildScrollView(
                child: Text(product.description),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.eco_outlined),
                  onPressed: () {
                    // Implementa la lógica de feedback
                  },
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Consumer(
                    builder: (context, ref, child) {
                      // builder: (context, watch, child) {
                      final cartItems = ref.watch(cartNotifierProvider);
                      final isProductInCart =
                          cartItems.any((item) => item.productId == productId);

                      return ElevatedButton(
                        onPressed: isProductInCart
                            ? null // Desactiva el botón si el producto ya está en el carrito
                            : () {
                                ref
                                    .read(cartNotifierProvider.notifier)
                                    .addProductToCart(
                                      productId,
                                      product.nameProduct,
                                      1,
                                      product.price,
                                    );
                              },
                        style: const ButtonStyle(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(isProductInCart
                                ? Icons.check
                                : Icons.shopping_cart),
                            const SizedBox(width: 8.0),
                            Text(isProductInCart
                                ? 'PRODUCTO AGREGADO'
                                : 'AGREGAR AL CARRITO'),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

final isFavoriteProvider =
    FutureProvider.family.autoDispose((ref, int productId) async {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return await localStorageRepository.isProductFavorite(productId);
});

class _SliderAppBar extends ConsumerWidget {
  const _SliderAppBar({
    required this.product,
  });

  final ProductClient product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavoriteFuture = ref.watch(isFavoriteProvider(product.id));
    final colors = Theme.of(context).colorScheme;
    return IconButton(
      onPressed: () async {
        await ref
            .read(productsFavoriteProvider.notifier)
            .toggleFavorite(product);
        ref.invalidate(isFavoriteProvider(product.id));
      },
      icon: isFavoriteFuture.when(
        loading: () => const CircularProgressIndicator(strokeWidth: 2),
        data: (isFavorite) => isFavorite
            ? Icon(
                Icons.favorite_rounded,
                color: colors.primary,
              )
            : Icon(
                Icons.favorite_outline_rounded,
                color: colors.primary,
              ),
        error: (_, __) => throw UnimplementedError(),
      ),
    );
  }
}

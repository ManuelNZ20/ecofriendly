import 'package:ecofriendly_flutter_app/features/client/domain/entities/product_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/shared/shared.dart';
import '../../riverpod/products_provider.dart';
import '../../riverpod/storage/local_storage.riverpod.dart';

class ProductDetailScreen extends ConsumerWidget {
  final int productId;
  const ProductDetailScreen({
    super.key,
    required this.productId,
  });

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
                    // Implementa la lógica del carrito
                  },
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO Implementa la lógica de agregar al carrito
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart),
                        SizedBox(width: 8.0),
                        Text('AGREGAR AL CARRITO'),
                      ],
                    ),
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
    // final isFavoriteFuture = ref.watch(isFavoriteProvider(product.id));
    final colors = Theme.of(context).colorScheme;
    return IconButton(
      onPressed: () {
        print('F');
        ref.watch(localStorageRepositoryProvider).toggleFavorite(product);
        ref.read(productsProvider.notifier).toggleFavorite(product.id);
        // ref.invalidate(isFavoriteProvider(product.id));
      },
      icon: Icon(
        ref.watch(productsProvider.select((state) => state.products
                .firstWhere((product) => product.id == product.id)
                .isFavorite!))
            ? Icons.favorite
            : Icons.favorite_border,
        color: colors.primary,
      ),
      /* isFavoriteFuture.when(
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
      ), */
    );
  }
}

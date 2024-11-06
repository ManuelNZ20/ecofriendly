import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/shared/shared.dart';
import '../../riverpod/category_provider.dart';
import '../../riverpod/products_provider.dart';
import '../../widgets/grid_view_products_client_all.dart';

class ProductsByIdCategoryScreen extends ConsumerWidget {
  static const name = 'products-all-screen';
  const ProductsByIdCategoryScreen({
    super.key,
    required this.categoryId,
  });

  final String categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleNumber = Theme.of(context).textTheme.titleLarge!.copyWith();
    final int idCategory = int.parse(categoryId);
    final category = ref.watch(categoryProvider(categoryId));
    final products = ref
        .watch(productsProvider.notifier)
        .getProductsByIdCategory(idCategory: idCategory);
    final messageEmpty = Theme.of(context).textTheme.bodySmall!.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w300,
          fontSize: 14,
        );
    return Scaffold(
        appBar: AppBar(
          leading: const IconButtonArrowBack(),
          title: category.isLoading
              ? const Text('Cargando...')
              : Text(category.categoryCard!.name),
          actions: [
            Text(
              '${products.length}',
              style: titleNumber,
            ),
            const SizedBox(width: 5),
            const Icon(
              Icons.category_rounded,
            ),
          ],
        ),
        body: products.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 2,
                  vertical: 2,
                ),
                child: GridViewProductsClientAll(
                  products: products,
                  isPromotion: true,
                ))
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.layers_clear_outlined,
                      size: 50,
                      weight: .5,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Sin productos',
                      style: messageEmpty,
                    ),
                  ],
                ),
              ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/entities.dart';
import 'card_product_favorite.dart';

class GridViewProductsClientAllFavorite extends ConsumerWidget {
  const GridViewProductsClientAllFavorite({
    super.key,
    required this.products,
  });

  final List<ProductClient> products;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return products.isNotEmpty
        ? GridView.builder(
            itemCount: products.length,
            padding: const EdgeInsets.all(5),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              mainAxisExtent: 250,
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              return CardProductFavorite(
                id: product.id,
                name: product.nameProduct,
                img: product.img,
                location: '/home/0/product/${product.id}',
                isFavorite: product.isFavorite!,
                price: product.price,
              );
            },
          )
        : const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.energy_savings_leaf_outlined),
                Text('Sin favoritos'),
              ],
            ),
          );
  }
}

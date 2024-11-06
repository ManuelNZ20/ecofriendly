import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../riverpod/products_provider.dart';
import '../../widgets/grid_view_products_client_all_favorite.dart';

class FavoritesView extends ConsumerWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productFavorites = ref.watch(productsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos Favoritos'),
      ),
      body: GridViewProductsClientAllFavorite(
        products: productFavorites.products
            .where((e) => e.isFavorite == true)
            .toList(),
      ),
    );
  }
}

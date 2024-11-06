import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../riverpod/storage/favorite_products.riverpod.dart';
import '../../widgets/grid_view_products_client_all_favorite.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLastPage = false;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;
    final products =
        await ref.read(productsFavoriteProvider.notifier).loadNextPage();
    isLoading = false;
    if (products.isEmpty) {
      isLastPage = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoritesProducts =
        ref.watch(productsFavoriteProvider).values.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: GridViewProductsClientAllFavorite(
        products: favoritesProducts,
      ),
    );
  }
}

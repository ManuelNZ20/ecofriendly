import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/entities.dart';
import 'card_product_favorite.dart';

class GridViewProductsFavorite extends ConsumerStatefulWidget {
  const GridViewProductsFavorite({
    super.key,
    required this.products,
    required this.loadNextPage,
  });

  final List<ProductClient> products;
  final VoidCallback? loadNextPage;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GridViewProductsFavoriteState();
}

class _GridViewProductsFavoriteState
    extends ConsumerState<GridViewProductsFavorite> {
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;
      if (scrollController.position.pixels + 100 >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = widget.products;
    if (products.isNotEmpty) {
      return GridView.builder(
        controller: scrollController,
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
          return FadeInUp(
            child: CardProductFavorite(
              id: product.id,
              name: product.nameProduct,
              img: product.img,
              location: '/home/0/product/${product.id}',
              isFavorite: product.isFavorite!,
              price: product.price,
            ),
          );
        },
      );
    }
    final colors = Theme.of(context).colorScheme;
    final title = Theme.of(context).textTheme.bodyLarge;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.energy_savings_leaf_outlined,
            color: colors.primary,
            size: 60,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 200,
            child: Text(
              'No tienes productos favoritos',
              style: title,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

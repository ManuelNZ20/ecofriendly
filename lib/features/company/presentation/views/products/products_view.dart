import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/products_provider.riverpod.dart';
import '../../widgets/grid_view_products_all.dart';

class ProductsView extends ConsumerWidget {
  const ProductsView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsByCompanyProvider);
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(productsByCompanyProvider);
      },
      child: products.when(
        data: (data) {
          if (data.isEmpty) {
            return const Center(
              child: Text('No tiene productos'),
            );
          }
          final products = data;
          return GridViewProductsAll(
            products: products,
            isPromocion: false,
            isFavorite: true,
          );
        },
        error: (error, stackTrace) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Se presento el siguiente error $error'),
              const SizedBox(height: 20),
              TextButton.icon(
                onPressed: () async =>
                    ref.invalidate(productsByCompanyProvider),
                label: const Text('Intentar otra vez'),
                icon: const Icon(Icons.replay_outlined),
              )
            ],
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        },
      ),
    );
  }
}

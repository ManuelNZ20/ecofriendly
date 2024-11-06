import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/shared/shared.dart';
import '../../riverpod/products_provider.dart';
import '../../widgets/grid_view_products_client_all.dart';

class ProductsAllScreen extends ConsumerWidget {
  static const name = 'products-all-screen';
  const ProductsAllScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider.notifier).getProducts();
    return Scaffold(
      appBar: AppBar(
        leading: const IconButtonArrowBack(),
        title: const Text('Productos'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 2,
          vertical: 2,
        ),
        child: FutureBuilder(
          future: products,
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(
                child: Text('Vacío'),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.connectionState == ConnectionState.none) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              );
            }
            final data = snapshot.data;
            return GridViewProductsClientAll(
              products: data!,
              isPromotion: false,
            );
          },
        ),
      ),
    );
  }
}

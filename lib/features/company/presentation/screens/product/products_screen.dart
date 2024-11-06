import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/shared/shared.dart';
import '../../providers/products_provider.riverpod.dart';
import '../../widgets/grid_view_products_all.dart';
import '../screens.dart';

class ProductsScreen extends ConsumerWidget {
  static const String name = 'products_screen';
  const ProductsScreen({
    super.key,
    required this.idInventory,
  });
  final int idInventory;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsByInventoryProvider(idInventory));
    return RefreshIndicator(
      onRefresh: () async =>
          await ref.watch(productsByInventoryProvider(idInventory)),
      child: Scaffold(
        appBar: AppBar(
          leading: const IconButtonArrowBack(),
          title: const Text('Productos A'),
        ),
        body: RefreshIndicator(
          onRefresh:
              ref.watch(productsProvider.notifier).getProductsOutstanding,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 2,
              vertical: 2,
            ),
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
                );
              },
              error: (error, stackTrace) {
                return const Center(
                  child: Text('Se presento el siguiente error'),
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
            // FutureBuilder(
            //   future: products,
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData &&
            //         snapshot.connectionState == ConnectionState.done) {
            //       final products = snapshot.data;
            //       return GridViewProductsAll(
            //         products: products!,
            //         isPromocion: false,
            //       );
            //     }
            //     if (snapshot.connectionState != ConnectionState.waiting) {
            //       return const Center(
            //         child: Text('Sin productos'),
            //       );
            //     }
            //   },
            // ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.pushNamed(
            ProductCompanyScreen.name,
            pathParameters: {
              'id_product': 'new',
              'id_inventory': idInventory.toString(),
            },
            extra: {
              'id_data': idInventory,
            },
          ),
          label: const Text('Producto'),
          icon: const Icon(Icons.add_rounded),
        ),
      ),
    );
  }
}

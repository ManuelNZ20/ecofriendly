import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../riverpod/banners_provider.dart';
import '../../riverpod/products_provider.dart';
import '../../widgets/horizontal_products_listview.dart';
import '../../widgets/widgets.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(productsProvider);
        ref.invalidate(bannersProvider);
      },
      child: CustomScrollView(
        slivers: [
          const SliverAppBar(
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: CustomAppBar(),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (context, index) {
                return Column(
                  children: [
                    const UserOptionHomeView(),
                    const CustomSlideShow(),
                    !products.isLoading
                        ? HorizontalProductsListView(
                            products: products.products
                                .where((element) =>
                                    element.idproductdiscount.isNotEmpty)
                                .toList(),
                            title: 'Populares',
                            isPromotion: false,
                          )
                        : const _LoadingHorizontalProductsListView(),
                    !products.isLoading
                        ? HorizontalProductsListView(
                            products: products.products,
                            title: 'Oferta de productos',
                            isPromotion: true,
                          )
                        : const _LoadingHorizontalProductsListView(),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class _LoadingHorizontalProductsListView extends StatelessWidget {
  const _LoadingHorizontalProductsListView();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 360,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

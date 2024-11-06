import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../company/presentation/widgets/card_product.dart';
import '../../domain/entities/entities.dart';
import '../riverpod/products_provider.dart';

class GridViewProductsClientAll extends ConsumerWidget {
  const GridViewProductsClientAll({
    super.key,
    required this.products,
    this.isFavorite = false,
    this.isPromotion = false,
    this.offPercentage = const [],
  });

  final List<ProductClient> products;
  final bool? isFavorite;
  final bool? isPromotion;
  final List<double>? offPercentage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      itemCount: products.length,
      padding: const EdgeInsets.all(5),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        mainAxisExtent: 300,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return isPromotion!
            ? CardProduct(
                location: '/home/0/product/${product.id}',
                name: product.nameProduct,
                brand: product.brand,
                priceOriginal: product.price -
                    (product.idproductdiscount.isEmpty
                        ? 0
                        : (product.price * product.discountpercentage)),
                img: product.img,
                onPressedFavorite: () {
                  ref
                      .read(productsProvider.notifier)
                      .toggleFavorite(product.id);
                },
                isFavorite: product.isFavorite!,
                isPromocion: isPromotion!,
                priceDiscountApplied: product.price,
                offPercentage: product.idproductdiscount.isEmpty
                    ? 0
                    : product.discountpercentage,
              )
            : CardProduct(
                location: '/home/0/product/${product.id}',
                name: product.nameProduct,
                brand: product.brand,
                priceOriginal: product.price,
                img: product.img,
                isFavorite: product.isFavorite!,
                onPressedFavorite: () {
                  ref
                      .read(productsProvider.notifier)
                      .toggleFavorite(product.id);
                },
                isPromocion: isPromotion!,
              );
      },
    );
  }
}

import 'package:flutter/material.dart';
import '../../domain/domain.dart';
import 'card_product.dart';

class GridViewProductsAll extends StatelessWidget {
  const GridViewProductsAll({
    super.key,
    required this.products,
    this.isFavorite = false,
    this.isPromocion = false,
    this.offPercentage = const [],
  });

  final List<Product> products;
  final bool? isFavorite;
  final bool? isPromocion;
  final List<double>? offPercentage;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: products.length,
      padding: const EdgeInsets.all(5),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        mainAxisExtent: 270,
      ),
      itemBuilder: (context, index) {
        final product = products[index];

        return CardProduct(
          name: product.nameProduct,
          brand: product.brand,
          priceOriginal: product.price,
          priceDiscountApplied: product.price,
          img: product.img,
          isPromocion: false,
          location: '/home_company/product/${product.id}',
        );
      },
    );
  }
}

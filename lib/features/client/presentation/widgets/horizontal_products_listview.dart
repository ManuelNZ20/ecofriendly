import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../company/presentation/widgets/card_product.dart';
import '../../domain/entities/product_client.dart';
import '../riverpod/products_provider.dart';

class HorizontalProductsListView extends ConsumerWidget {
  const HorizontalProductsListView({
    super.key,
    required this.products,
    required this.title,
    required this.isPromotion,
  });
  final List<ProductClient> products;
  final String title;
  final bool isPromotion;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 360,
      child: Column(
        children: [
          _Title(title: title),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final product = products[index];
                return Container(
                  width: 190,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: product.idproductdiscount.isNotEmpty
                      ? CardProduct(
                          location: '/home/0/product/${product.id}',
                          name: product.nameProduct,
                          brand: product.brand,
                          priceOriginal: product.price -
                              (product.price * product.discountpercentage),
                          img: product.img,
                          onPressedFavorite: () {
                            ref
                                .read(productsProvider.notifier)
                                .toggleFavorite(product.id);
                          },
                          isFavorite: product.isFavorite!,
                          isPromocion: isPromotion,
                          priceDiscountApplied: product.price,
                          offPercentage: product.discountpercentage,
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
                          isPromocion: isPromotion,
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme.bodyLarge!;
    final textStyleButton = Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: colors.primary,
          fontWeight: FontWeight.w600,
        );
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Text(
            title,
            style: textStyle,
          ),
          const Spacer(),
          TextButton(
            onPressed: () => context.push('/home/0/products-all'),
            child: Text(
              'Ver Todo',
              style: textStyleButton,
            ),
          ),
        ],
      ),
    );
  }
}

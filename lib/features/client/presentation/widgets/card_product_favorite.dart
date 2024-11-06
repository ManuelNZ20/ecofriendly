import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/theme/theme.dart';
import '../riverpod/products_provider.dart';

class CardProductFavorite extends ConsumerWidget {
  const CardProductFavorite({
    super.key,
    required this.id,
    required this.name,
    required this.img,
    required this.location,
    required this.isFavorite,
    required this.price,
  });
  final int id;
  final String name;
  final String img;
  final String location;
  final bool isFavorite;
  final double price;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context);
    final titleName = Theme.of(context).textTheme.titleLarge!.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w300,
        );
    final titlePrice = Theme.of(context).textTheme.titleLarge!.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: colors.colorScheme.primary);
    return GestureDetector(
      onTap: () => context.push(location),
      child: Container(
        width: size.width,
        clipBehavior: Clip.hardEdge,
        padding: const EdgeInsets.symmetric(
          horizontal: 6,
        ),
        decoration: ShapeDecoration(
          color: colors.scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: SizesApp.sizesCartScreen.wBorderSide - .7,
              color: colors.colorScheme.primary,
            ),
            borderRadius:
                BorderRadius.circular(SizesApp.sizesCartScreen.borderRadious),
          ),
          shadows: listShadowCard,
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              bottom: 50,
              child: SizedBox(
                width: size.width * .4,
                height: 50,
                child: Text(
                  name,
                  style: titleName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: SizedBox(
                width: size.width * .4,
                height: 50,
                child: Text(
                  'S/.$price',
                  style: titlePrice,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.network(
                img,
                width: size.width,
                height: size.height * .15,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return SizedBox(
                      width: size.width * .4,
                      height: size.height * .15,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return child;
                },
              ),
            ),
            Positioned(
              right: 0,
              child: IconButton(
                onPressed: () {
                  ref.read(productsProvider.notifier).toggleFavorite(id);
                },
                icon: Icon(
                  Icons.close_rounded,
                  color: Theme.of(context).colorScheme.primary,
                  size: 35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

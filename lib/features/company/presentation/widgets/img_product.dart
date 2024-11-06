import 'package:flutter/material.dart';

class ImageProduct extends StatelessWidget {
  const ImageProduct({
    super.key,
    required this.img,
    required this.isFavorite,
    bool? promotion,
    double? percentage,
    this.onPressedFavorite,
  })  : isPromocion = promotion ?? false,
        offPercentage = percentage ?? 0.0;
  final String img;
  final bool isFavorite;
  final bool isPromocion;
  final double offPercentage;
  final void Function()? onPressedFavorite;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final titlePromotion = Theme.of(context).textTheme.titleMedium!.copyWith(
          color: Theme.of(context).colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        );
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 10,
          ),
          child: Image.network(
            width: size.width,
            height: size.height * .15,
            img,
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
            onPressed: onPressedFavorite,
            icon: Icon(
              isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: Colors.grey[400],
            ),
          ),
        ),
        isPromocion
            ? Positioned(
                left: 2,
                top: 6,
                child: Container(
                  width: 80,
                  height: 25,
                  padding: EdgeInsets.zero,
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '${(offPercentage * 100).toInt()}% OFF',
                      style: titlePromotion,
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}

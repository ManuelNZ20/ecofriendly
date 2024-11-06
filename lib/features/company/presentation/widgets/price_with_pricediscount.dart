import 'package:flutter/material.dart';

class PriceWithPriceDiscount extends StatelessWidget {
  const PriceWithPriceDiscount({
    super.key,
    required this.priceOriginal,
    required this.priceDiscountApplied,
    this.isPromotion,
  });
  final double priceOriginal;
  final double priceDiscountApplied;
  final bool? isPromotion;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final titlePrice = Theme.of(context).textTheme.titleMedium!.copyWith(
          fontSize: 16,
          color: const Color(0xFFD19E63),
          letterSpacing: 1.2,
          overflow: TextOverflow.ellipsis,
        );
    final titlePriceDiscount =
        Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 12,
              color: Colors.grey,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.lineThrough,
              decorationColor: Colors.grey,
              decorationStyle: TextDecorationStyle.solid,
            );
    return SizedBox(
      width: size.width,
      height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: size.width * .2,
            child: Text(
              'S/. $priceOriginal',
              style: titlePrice,
            ),
          ),
          isPromotion!
              ? Text(
                  'S/. $priceDiscountApplied',
                  style: titlePriceDiscount,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../config/theme/theme.dart';

class ChipPercentage extends StatelessWidget {
  const ChipPercentage({
    super.key,
    required this.percentage,
  });

  final double percentage;

  @override
  Widget build(BuildContext context) {
    final styleText = Theme.of(context).textTheme.bodySmall!.copyWith(
          fontWeight: FontWeight.w700,
          height: 0.15,
          letterSpacing: 0.10,
        );
    return Container(
      height: 25,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: MyColors.mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              SizesApp.sizesCartScreen.chipPercentageBorderRadious),
        ),
        shadows: listShadowCard,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Text(
              '$percentage% OFF',
              textAlign: TextAlign.center,
              style: styleText,
            ),
          ),
        ],
      ),
    );
  }
}

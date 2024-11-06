import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TitleIconProfile extends StatelessWidget {
  const TitleIconProfile({
    super.key,
    required this.text,
    iconData,
  }) : iconData = iconData ?? Icons.info_outline;
  final String text;
  final IconData? iconData;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTitle = Theme.of(context).textTheme.titleMedium!.copyWith(
          color: colors.primary,
        );
    return Row(
      children: [
        FaIcon(
          iconData,
          color: colors.primary,
        ),
        const SizedBox(width: 20),
        Text(
          text,
          style: textTitle,
        ),
      ],
    );
  }
}

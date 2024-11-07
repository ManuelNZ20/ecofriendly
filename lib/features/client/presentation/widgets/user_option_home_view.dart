import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../config/theme/theme.dart';
import '../../../auth/presentation/riverpod/providers.dart';

class UserOptionHomeView extends ConsumerWidget {
  const UserOptionHomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final isDark = ref.watch(appThemeStateProvider);
    final listColors = ref.watch(listColorsProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {},
          child: const Text('Ecofriendly'),
        ),
        IconButton(
          icon: const Icon(Icons.eco_outlined),
          onPressed: () => ref.read(indexColorsProvider.notifier).update(
              (state) => (state >= listColors.length - 1) ? 0 : state + 1),
          color: colors.primary,
        ),
        IconButton(
          onPressed: () => ref.read(appThemeProvider.notifier).update(
                (state) => !state,
              ),
          icon: Icon(!isDark ? Icons.light_mode : Icons.dark_mode),
          color: !isDark
              ? MyColors.themeColors.lightMode
              : MyColors.themeColors.darkMode,
        ),
        IconButton(
          onPressed: ref.read(authProvider.notifier).logout,
          icon: const Icon(
            Icons.exit_to_app_rounded,
            color: MyColors.password,
          ),
        ),
      ],
    );
  }
}

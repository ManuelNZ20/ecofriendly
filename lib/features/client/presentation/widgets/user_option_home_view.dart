import 'package:ecofriendly_flutter_app/features/client/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../config/theme/theme.dart';
import '../../../auth/presentation/riverpod/providers.dart';

class UserOptionHomeView extends ConsumerWidget {
  const UserOptionHomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    // final isDark = ref.watch(appThemeProvider);
    final listColors = ref.watch(listColorsProvider);
    final indexColors = ref.watch(indexColorsStateProvider);
    final isDark = ref.watch(appThemeStateProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () => context.pushNamed(
            ProfileScreen.name,
            pathParameters: {
              'page': '0',
            },
          ),
          child: const Text('Ecofriendly'),
        ),
        IconButton(
          icon: const Icon(Icons.eco_outlined),
          onPressed: () {
            final newIndex =
                (indexColors >= listColors.length - 1) ? 0 : indexColors + 1;
            ref
                .read(indexColorsStateProvider.notifier)
                .updateColorIndex(newIndex);
          },
          color: colors.primary,
        ),
        IconButton(
          onPressed: () =>
              ref.read(appThemeStateProvider.notifier).toggleTheme(),
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

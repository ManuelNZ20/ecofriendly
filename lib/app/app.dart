import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/router/app_router.dart';
import '../config/theme/app_theme.dart';
import '../config/theme/theme.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);
    final isDark = ref.watch(appThemeProvider);
    final index = ref.watch(indexColorsProvider);
    final listColors = ref.watch(listColorsProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Ecofriendly App',
      routerConfig: appRouter,
      theme: AppTheme().themeData(
        isDark,
        index >= listColors.length ? listColors[0] : listColors[index],
      ),
    );
  }
}

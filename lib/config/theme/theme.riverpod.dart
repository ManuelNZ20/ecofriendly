import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/shared/shared.dart';
import 'theme.dart';

final List<Color> colorsTheme = [
  MyColors.mainColor,
  Colors.pink.shade400,
  Colors.orange.shade400,
  Colors.cyan.shade400,
  Colors.teal.shade900,
  Colors.brown,
  Colors.indigo.shade900,
];

final appThemeProvider = StateProvider<bool>((ref) {
  return false;
});

final indexColorsProvider = StateProvider<int>((ref) {
  return 0;
});

final listColorsProvider = Provider<List<Color>>((ref) {
  return colorsTheme;
});

final appThemeStateProvider =
    StateNotifierProvider<AppThemeNotifier, bool>((ref) {
  final keyValueStorageService = KeyValueStorageImpl();
  return AppThemeNotifier(keyValueStorageService);
});

class AppThemeNotifier extends StateNotifier<bool> {
  final KeyValueStorageImpl storage;
  static const themeKey = 'isDarkTheme';

  AppThemeNotifier(this.storage) : super(false) {
    _loadTheme();
  }

  void toggleTheme() {
    state = !state;
    storage.setKeyValue(themeKey, state);
  }

  Future<void> _loadTheme() async {
    final isDarkTheme = await storage.getValue<bool>(themeKey) ?? false;
    state = isDarkTheme;
  }
}

final indexColorsStateProvider =
    StateNotifierProvider<IndexColorsNotifier, int>((ref) {
  final keyValueStorageService = KeyValueStorageImpl();
  return IndexColorsNotifier(keyValueStorageService);
});

class IndexColorsNotifier extends StateNotifier<int> {
  final KeyValueStorageImpl storage;
  static const colorIndexKey = 'colorIndex';

  IndexColorsNotifier(this.storage) : super(0) {
    _loadColorIndex();
  }

  void updateColorIndex(int newIndex) {
    state = newIndex;
    storage.setKeyValue(colorIndexKey, state);
  }

  Future<void> _loadColorIndex() async {
    final colorIndex = await storage.getValue<int>(colorIndexKey) ?? 0;
    state = colorIndex;
  }
}

import 'package:flutter/material.dart';

class MyColors {
  static const mainColor = Color(0xFF1FA39D);
  static const password = Color(0xFF0080FF);

  static ColorsCart colorsCart = ColorsCart();
  static ThemeColors themeColors = ThemeColors();
}

class ColorsCart {
  Color get starColor => const Color(0xFFF5A61D);
  Color get buttonEco => const Color(0xFFBEC0C2);
}

class ThemeColors {
  Color get lightMode => const Color(0xFFF5A61D);
  Color get darkMode => const Color(0xFFBEC0C2);
}

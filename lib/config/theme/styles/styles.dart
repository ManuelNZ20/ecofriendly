import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final textTheme = TextTheme(
  titleLarge: GoogleFonts.nunito(),
  titleMedium: GoogleFonts.nunito(),
  bodyLarge: GoogleFonts.nunito(),
  bodySmall: GoogleFonts.nunitoSans(),
);
const filledButtonStyle = FilledButtonThemeData();
const appBarTheme = AppBarTheme(
  centerTitle: true,
  iconTheme: IconThemeData(),
);

final listShadowCard = <BoxShadow>[
  const BoxShadow(
    color: Color(0x26000000),
    blurRadius: 3,
    offset: Offset(0, 1),
    spreadRadius: 1,
  ),
  const BoxShadow(
    color: Color(0x4C000000),
    blurRadius: 2,
    offset: Offset(0, 1),
    spreadRadius: 0,
  )
];

final labelStyle = GoogleFonts.nunito();

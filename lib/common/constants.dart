import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// colors
const Color kYellow = Color(0xFFFFEE00);
const Color kDarkGray = Color(0xFF383838);
const Color kWhite = Color(0xFFFBFBFA);
const Color kLightGray = Color(0xFFF2F2F4);

// text styles
final TextStyle kManropeHeading1 = GoogleFonts.manrope(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

final TextStyle kManropeHeading5 = GoogleFonts.manrope(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: Colors.black,
);

final TextStyle kManropeSubtitle = GoogleFonts.manrope(
  fontSize: 13,
  fontWeight: FontWeight.w400,
  color: Colors.black54,
);

final TextStyle kManropeBodyText = GoogleFonts.manrope(
  fontSize: 16,
  fontWeight: FontWeight.normal,
  color: Colors.black87,
);

final kTextTheme = TextTheme(
  headlineMedium: kManropeHeading1,
  headlineSmall: kManropeHeading5,
  bodyMedium: kManropeSubtitle,
  bodySmall: kManropeBodyText,
);

// theme
const ColorScheme kColorSchemeLight = ColorScheme(
  brightness: Brightness.light,
  primary: kYellow,
  onPrimary: kDarkGray,
  secondary: kDarkGray,
  onSecondary: kWhite,
  error: Colors.red,
  onError: Colors.white,
  surface: kWhite,
  onSurface: kDarkGray,
);

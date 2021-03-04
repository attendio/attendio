import 'package:flutter/material.dart';

// Colors dictionary for easy reference to multiple custom colors
final Map<String, Color> colors = {
  'primary': Color(0xFF6A1B9A),
  'secondary': Color(0xFFD1C4E9),
  'shade': Color.fromRGBO(98, 0, 238, 0.08),
  'light_purple': Color(0xFFB39DDB)
};

final ColorScheme defaultColorScheme = ColorScheme.light().copyWith(
  primary: Color(0xFF6A1B9A),
  secondary: Color(0xFFD1C4E9),
);

final ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    elevation: 5,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
);

final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
);

// This is the global theme data
// Add any custom widget themes above before referencing in the globalTheme if possible
// Refer to Flutter Material docs for proper classes for custom themes
// https://api.flutter.dev/flutter/material/material-library.html
final ThemeData globalTheme = ThemeData(
  colorScheme: defaultColorScheme,
  elevatedButtonTheme: elevatedButtonTheme,
  inputDecorationTheme: inputDecorationTheme,
);

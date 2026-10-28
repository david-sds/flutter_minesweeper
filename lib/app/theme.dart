import 'package:flutter/material.dart';

Color get seedColor => Colors.greenAccent;

ThemeData getThemeData(ColorScheme colorScheme) => ThemeData(
      colorScheme: colorScheme,
      appBarTheme: const AppBarTheme().copyWith(
        color: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      scaffoldBackgroundColor: colorScheme.inversePrimary,
      canvasColor: colorScheme.onSecondary,
      textTheme: TextTheme(
        titleMedium: TextStyle(
          color: colorScheme.secondary,
          fontSize: 16,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        prefixIconColor: colorScheme.primary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: BorderSide(
            width: 1,
            color: colorScheme.secondary,
          ),
        ),
        filled: true,
        fillColor: colorScheme.secondaryContainer,
        labelStyle: TextStyle(color: colorScheme.secondary),
        iconColor: colorScheme.primary,
        contentPadding: EdgeInsets.only(left: 6),
      ),
      iconTheme: IconThemeData(
        color: colorScheme.primary,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.secondaryContainer,
        side: BorderSide(color: colorScheme.secondary),
        labelStyle: TextStyle(color: colorScheme.secondary),
        iconTheme: IconThemeData(color: colorScheme.primary),
      ),
    );

final defaultLightTheme = ColorScheme.light();
final defaultDarkTheme = ColorScheme.dark();

final lightTheme = ColorScheme.fromSeed(
  seedColor: seedColor,
  brightness: Brightness.light,
);

final darkTheme = ColorScheme.fromSeed(
  seedColor: seedColor,
  brightness: Brightness.dark,
);

// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handlit_flutter/utils/styles/palette.dart';

class CustomThemeData {
  static final ThemeData lightMode = ThemeData(
    useMaterial3: true,
    primaryColor: Palette.primaryColor,
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Palette.scaffoldBackgroundColor,
    canvasColor: Palette.backgroundColor,
    disabledColor: Palette.deActivatedTextColor,
    colorScheme: ColorScheme(
      background: Palette.backgroundColor,
      primary: Palette.primaryColor,
      secondary: Palette.accentColor,
      onSecondaryContainer: Palette.onSecondaryContainerColor,
      surface: Palette.scaffoldBackgroundColor,
      onBackground: Palette.primaryColor,
      onPrimary: Palette.primaryColor,
      onSecondary: Palette.backgroundColor,
      onSurface: Palette.accentColor,
      secondaryContainer: Palette.secondaryContainerColor,
      error: Palette.errorColor,
      onError: Palette.backgroundColor,
      brightness: Brightness.light,
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(color: Palette.primaryColor, fontWeight: FontWeight.bold, fontSize: 26, height: 1.2),
      headlineMedium: TextStyle(color: Palette.primaryColor, fontWeight: FontWeight.bold, fontSize: 22, height: 1.2),
      headlineSmall: TextStyle(color: Palette.primaryColor, fontWeight: FontWeight.bold, fontSize: 18, height: 1.2),
      bodyLarge: TextStyle(color: Palette.primaryColor, fontWeight: FontWeight.w500, fontSize: 18, height: 1.2),
      bodyMedium: TextStyle(color: Palette.primaryColor, fontWeight: FontWeight.w500, fontSize: 14, height: 1.2),
      bodySmall: TextStyle(color: Palette.primaryColor, fontWeight: FontWeight.w400, fontSize: 13, height: 1.2),
      labelSmall: TextStyle(color: Palette.primaryColor, fontWeight: FontWeight.w400, fontSize: 12, height: 1.2),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(Palette.accentColor),
      fillColor: MaterialStateProperty.all(Palette.primaryColor),
    ),
    cardColor: Palette.backgroundColor,
    iconTheme: const IconThemeData().copyWith(color: Palette.primaryColor),
    dialogBackgroundColor: Color.fromARGB(255, 83, 83, 83),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: Palette.accentColor,
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Palette.accentColor,
        ),
      ),
      hintStyle: TextStyle(color: Colors.white54),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Palette.accentColor,
      selectionColor: Palette.accentColor,
      selectionHandleColor: Palette.accentColor,
    ),
    secondaryHeaderColor: Palette.primaryColor.withAlpha(127),
    scrollbarTheme: ScrollbarThemeData(
      interactive: true,
      radius: const Radius.circular(10.0),
      thumbColor: MaterialStateProperty.all(Palette.primaryColor.withAlpha(150)),
      thickness: MaterialStateProperty.all(5.0),
      minThumbLength: 100,
    ),
    appBarTheme: AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.dark),
  );
}

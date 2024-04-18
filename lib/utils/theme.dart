import 'dart:async';

import 'package:delo_automotive/utils/constants.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static StreamController<ThemeMode> currentThemeStream = StreamController.broadcast();
  static ThemeMode currentTheme = ThemeMode.light;

  static void initStream() {
    currentThemeStream.add(ThemeMode.light);
  }

  static void toggleTheme({ThemeMode themeMode = ThemeMode.light}) {
    currentTheme = themeMode;
    currentThemeStream.add(themeMode);
  }

  static ThemeData appLightTheme() {
    return ThemeData(
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
          background: Constants.lightThemeBg,
        ),
        listTileTheme: const ListTileThemeData(
            tileColor: Constants.lightThemeTileColor,
            titleTextStyle:
                TextStyle(color: Constants.lightThemeText, fontFamily: 'SF Pro', fontSize: 26, fontWeight: FontWeight.w400),
            subtitleTextStyle:
                TextStyle(color: Constants.lightThemeSubtitle, fontFamily: 'SF Pro', fontSize: 18, fontWeight: FontWeight.w400)),
        iconTheme: const IconThemeData(
          color: Constants.lightThemeBlue,
        ),
        disabledColor: Constants.lightThemeSubtitle);
  }

  static ThemeData appDarkTheme() {
    return ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          background: Constants.darkThemeBg,
        ),
        listTileTheme: const ListTileThemeData(
            tileColor: Constants.darkThemeTileColor,
            titleTextStyle:
                TextStyle(color: Constants.darkThemeText, fontFamily: 'SF Pro', fontSize: 26, fontWeight: FontWeight.w400),
            subtitleTextStyle:
                TextStyle(color: Constants.darkThemeSubtitle, fontFamily: 'SF Pro', fontSize: 18, fontWeight: FontWeight.w400)),
        iconTheme: const IconThemeData(color: Constants.darkThemeBlue),
        disabledColor: Constants.darkThemeSubtitle);
  }
}

import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

final kTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: const Color(0xffe9435a),
  scaffoldBackgroundColor: Colors.white,
  splashColor: const Color(0x11e9435a),
  highlightColor: const Color(0x33e9435a),
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    foregroundColor: Colors.black,
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontSize: Sizes.size18,
      fontWeight: FontWeight.w600,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  textTheme: Typography.blackCupertino,
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Color(0xffe9435a),
  ),
  tabBarTheme: TabBarTheme(
    labelColor: Colors.black,
    unselectedLabelColor: Colors.grey.shade500,
    indicatorColor: Colors.black,
  ),
);

final kDarkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  primaryColor: const Color(0xffe9435a),
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey.shade900,
    surfaceTintColor: Colors.grey.shade900,
    elevation: 0,
    titleTextStyle: const TextStyle(
      fontSize: Sizes.size18,
      fontWeight: FontWeight.w600,
    ),
    actionsIconTheme: const IconThemeData(
      color: Colors.white,
    ),
    
  ),
  bottomAppBarTheme: BottomAppBarTheme(
    color: Colors.grey.shade900,
  ),
  textTheme: Typography.whiteCupertino,
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Color(0xffe9435a),
  ),
  tabBarTheme: TabBarTheme(
    labelColor: Colors.white,
    unselectedLabelColor: Colors.grey.shade500,
    indicatorColor: Colors.white,
  ),
);

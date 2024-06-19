import 'package:bloc_app/app/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border(Color color) =>  OutlineInputBorder(
    borderSide: BorderSide(
      color: color,
      width: 2
    ),
    borderRadius: BorderRadius.circular(10)
  );
  final darkModeTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColor.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.backgroundColor,
    ),
    chipTheme: ChipThemeData(
      side: BorderSide.none,
      color: MaterialStatePropertyAll(AppColor.backgroundColor)
    ),
    inputDecorationTheme:InputDecorationTheme(
      contentPadding:const EdgeInsets.all(20),
      enabledBorder: _border( AppColor.borderColor),
      focusedBorder: _border( AppColor.gradient2Color),
      errorBorder: _border(AppColor.errorColor),
      focusedErrorBorder: _border(AppColor.errorColor),
    )
  );
}
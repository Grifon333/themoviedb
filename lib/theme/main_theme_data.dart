import 'package:flutter/material.dart';
import 'package:themoviedb/theme/app_colors.dart';

final ThemeData mainThemeData = ThemeData(
  useMaterial3: false,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.darkBlue,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.darkBlue,
    selectedItemColor: AppColors.selectedTab,
    unselectedItemColor: AppColors.unselectedTab,
  ),
);
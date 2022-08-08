import 'package:flutter/material.dart';
import 'package:themoviedb/Theme/app_colors.dart';

abstract class AppButtonStyle {
  static final login = ButtonStyle(
    padding: MaterialStateProperty.all(
      const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 6,
      ),
    ),
    backgroundColor: MaterialStateProperty.all(
      const Color(0xFF01B4E4),
    ),
  );

  static const decorationButton = InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.enableBorder,
        width: 1.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.focusedBorder,
        width: 1.0,
      ),
    ),
    isCollapsed: true,
    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  );
}
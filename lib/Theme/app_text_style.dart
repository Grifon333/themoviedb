import 'package:flutter/material.dart';
import 'package:themoviedb/Theme/app_colors.dart';

abstract class AppTextStyle {

  static const mainText = TextStyle(
    fontSize: 16,
    color: Colors.black,
  );
  static const title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );
  static const linkText = TextStyle(
    color: AppColors.lightBlue,
  );
  static const titleOfTextField = TextStyle(fontSize: 16);
  static const errorTitle = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  static const errorText = TextStyle(
    color: Colors.black,
    fontSize: 16,
  );

  // Films
  static const titleFilmInCard = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  static const dataFilmInCard = TextStyle(
    fontSize: 14,
    color: AppColors.dataText,
  );
  static const descriptionFilmInCard = TextStyle(fontSize: 14);

  static const login = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );
  static const resetPassword = TextStyle(
    fontSize: 16,
    color: AppColors.lightBlue,
  );
}
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

  // MovieInfo
  static const titleMovie = TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static const foundationYear = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: Colors.white70,
  );
  static const userScore = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );
  static const playTrailer = TextStyle(
    fontSize: 16,
    color: Colors.white,
  );
  static const facts = TextStyle(
    fontSize: 16,
    color: Colors.white,
  );
  static const overviewTitle = TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static const overviewBody = TextStyle(
    fontSize: 16,
    color: Colors.white,
  );
  static const personCardName = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );
  static const personCardRole = TextStyle(color: Colors.white);
}
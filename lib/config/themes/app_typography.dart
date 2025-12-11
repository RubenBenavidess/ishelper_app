import 'package:flutter/material.dart';
import 'package:ishelper_app/config/themes/app_colors.dart';

class AppTypography {

  // Private Constructor (flutter static way)
  AppTypography._();

  static const TextStyle h1 = TextStyle(
    fontSize: 50,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryTextColor,
    fontFamily: 'Roboto Mono',
    letterSpacing: -0.5,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w800,
    color: AppColors.primaryTextColor
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryTextColor
  );

  static const TextStyle h4 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.secondaryBgColor
  );

  static const TextStyle descriptionText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.tertiaryTextColor
  );

  static final TextStyle descriptionTextBold = TextStyle(
    fontSize: 16,
    fontFamily: 'Raleway',
    fontWeight: FontWeight.w700,
    fontVariations: [FontVariation.italic(1)],
    color: AppColors.tertiaryTextColor
  );

  static const TextStyle navBarText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryTextColor
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryTextColor,
  );

  static const TextStyle inputsText = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.black
  );

  static const TextStyle labelText = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.white
  );

  static const TextStyle errorInputText = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w800,
      color: Colors.redAccent
  );

  static const TextStyle successInputText = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w800,
      color: AppColors.secondaryBtnColor
  );

  static const TextStyle solutionsTitle = TextStyle(
    fontSize: 36,
    fontFamily: 'Raleway',
    fontWeight: FontWeight.bold,
    color: AppColors.secondaryBgColor
  );

  static const TextStyle solutionsCategory = TextStyle(
    fontSize: 23,
    fontFamily: 'Raleway',
    fontWeight: FontWeight.bold,
    color: AppColors.categoryColor
  );

}
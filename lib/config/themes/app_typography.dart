import 'package:flutter/material.dart';
import 'package:ishelper_app/config/themes/app_colors.dart';

class AppTypography {

  // Private Constructor (flutter static way)
  AppTypography._();

  static const TextStyle h1 = TextStyle(
    fontSize: 50,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryTextColor,
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
    fontSize: 12,
    fontWeight: FontWeight.w600,
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
      fontWeight: FontWeight.w700,
      color: Colors.redAccent
  );

}
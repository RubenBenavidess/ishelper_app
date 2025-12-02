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
    fontSize: 22,
    fontWeight: FontWeight.w300,
    color: AppColors.primaryTextColor
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryTextColor
  );

  static const TextStyle h4 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryTextColor
  );

  static const TextStyle h5 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.secondaryTextColor
  );

  static const TextStyle descriptionText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.tertiaryTextColor
  );

  static const TextStyle navBarText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryTextColor
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.primaryTextColor
  );

  static const TextStyle inputsText = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black
  );

}
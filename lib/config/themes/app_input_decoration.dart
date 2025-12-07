import 'package:flutter/material.dart';
import 'package:ishelper_app/config/themes/app_colors.dart';
import 'package:ishelper_app/config/themes/app_typography.dart';

class AppInputDecoration {

  static InputDecoration generateISInputDecoration({
    String hint = "",
    String? errorMessage
  }){
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: AppColors.tertiaryTextColor,
        fontWeight: FontWeight.w700
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.horizontal()
      ),
      filled: true,
      fillColor: AppColors.inputBgColor,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.horizontal(),
        borderSide: BorderSide(
          color: AppColors.inputFocusColor,
          width: 2
        )
      ),
      errorText: errorMessage,
      errorStyle: AppTypography.errorInputText,
      errorMaxLines: 2
    );
  }



}
import 'package:flutter/material.dart';
import 'package:ishelper_app/config/themes/app_colors.dart';

class AppInputDecoration {

  static InputDecoration generateISInputDecoration({
    String label = "",
    String hint = "",
    String? errorMessage
  }){
    return InputDecoration(
      labelText: label,
      hintText: hint,
      hintStyle: TextStyle(
        color: AppColors.tertiaryTextColor
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
      errorText: errorMessage
    );
  }



}
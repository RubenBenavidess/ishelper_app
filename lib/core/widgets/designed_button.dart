import 'package:flutter/material.dart';
import 'package:ishelper_app/core/themes/app_colors.dart';
import 'package:ishelper_app/core/themes/app_typography.dart';

enum ButtonVariant { primary, secondary, tertiary }

class DesignedButton extends StatelessWidget{

  final bool isRounded;
  final String label;
  final ButtonVariant btnVariant;
  final IconData? icon;

  const DesignedButton({
    super.key,
    this.isRounded = false,
    required this.label,
    this.btnVariant = ButtonVariant.primary,
    this.icon
  });

  @override
  Widget build(BuildContext context) {
    
    final btnColor = _getButtonColor();

    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 20),
          const SizedBox(width: 8),
        ],
        Text(
          label,
          style: AppTypography.buttonText
        ),
      ],
    );

    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: btnColor,
      elevation: btnVariant == ButtonVariant.primary ? 2 : 0,
      shape: isRounded ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)) : ContinuousRectangleBorder(),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    );

    Widget button = ElevatedButton(
      onPressed: () {},
      style: buttonStyle,
      child: content,
    );

    return button;
  }

  Color _getButtonColor(){
    switch(btnVariant){
      case ButtonVariant.primary:
        return AppColors.primaryBtnColor;
      case ButtonVariant.secondary:
        return AppColors.secondaryBtnColor;
      case ButtonVariant.tertiary:
        return AppColors.tertiaryBgColor;
    }
  }

}
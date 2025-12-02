import 'package:flutter/material.dart';
import 'package:ishelper_app/config/themes/app_colors.dart';
import 'package:ishelper_app/config/themes/app_typography.dart';

/// An enumeration of the available button styles.
enum ButtonVariant {
  /// A primary button style with a prominent background color.
  primary,
  /// A secondary button style with a less prominent background color.
  secondary,
  /// A tertiary button style, often with a transparent or light background.
  tertiary
}

/// A custom-designed button widget with different visual variants.
///
/// This button can be configured with a label, an optional icon, and different
/// styles defined by [ButtonVariant]. It also supports a rounded or sharp corner style.
class DesignedButton extends StatelessWidget {
  /// Whether the button should have rounded corners. Defaults to `false`.
  final bool isRounded;
  /// The text to display inside the button.
  final String label;
  /// The visual style of the button. Defaults to [ButtonVariant.primary].
  final ButtonVariant btnVariant;
  /// An optional icon to display to the left of the label.
  final IconData? icon;
  /// The callback that is called when the button is tapped.
  final VoidCallback? onPressed;

  /// Creates a [DesignedButton].
  ///
  /// The [label] is required.
  const DesignedButton({
    super.key,
    this.isRounded = false,
    required this.label,
    this.btnVariant = ButtonVariant.primary,
    this.icon,
    this.onPressed,
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
        Text(label, style: AppTypography.buttonText),
      ],
    );

    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: btnColor,
      // foregroundColor: Colors.black,
      elevation: btnVariant == ButtonVariant.primary ? 2 : 0,
      shape: isRounded
          ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
          : ContinuousRectangleBorder(),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    );

    Widget button = ElevatedButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: content,
    );

    return button;
  }

  /// Returns the background color for the button based on the [btnVariant].
  Color _getButtonColor() {
    switch (btnVariant) {
      case ButtonVariant.primary:
        return AppColors.primaryBtnColor;
      case ButtonVariant.secondary:
        return AppColors.secondaryBtnColor;
      case ButtonVariant.tertiary:
        return AppColors.tertiaryBgColor;
    }
  }
}

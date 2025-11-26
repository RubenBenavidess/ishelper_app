import 'package:flutter/material.dart';
import 'package:ishelper_app/core/themes/app_colors.dart';
import 'package:ishelper_app/core/themes/app_typography.dart';

class ISNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const ISNavBar({
    super.key,
    this.currentIndex = 0,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      backgroundColor: AppColors.tertiaryBgColor,
      indicatorColor: AppColors.secondaryBgColor,
      elevation: 2,
      height: 70,
      labelTextStyle: WidgetStateTextStyle.resolveWith((states){
        return AppTypography.navBarText;
      }),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home, color: AppColors.tertiaryBgColor),
          label: 'Inicio',
        ),
        NavigationDestination(
          icon: Icon(Icons.grid_view_outlined),
          selectedIcon: Icon(Icons.grid_view, color: AppColors.tertiaryBgColor),
          label: 'Soluciones',
        ),
        NavigationDestination(
          icon: Icon(Icons.mail_outline),
          selectedIcon: Icon(Icons.mail, color: AppColors.tertiaryBgColor),
          label: 'Contacto',
        ),
        NavigationDestination(
          icon: Icon(Icons.headset_mic_outlined),
          selectedIcon: Icon(Icons.headset_mic, color: AppColors.tertiaryBgColor),
          label: 'Soporte',
        ),
      ],
    );
  }
}
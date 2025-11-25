import 'package:flutter/material.dart';
import 'package:ishelper_app/core/themes/app_colors.dart';

class ISBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const ISBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      backgroundColor: AppColors.tertiaryBgColor,
      indicatorColor: AppColors.secondaryBgColor,
      elevation: 3,
      
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
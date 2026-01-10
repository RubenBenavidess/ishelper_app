import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ishelper_app/config/themes/app_colors.dart';
import 'package:ishelper_app/config/themes/app_typography.dart';

/// A customized navigation bar for the application.
///
/// This widget builds a [NavigationBar] with predefined styling and destinations.
class ISNavBar extends StatelessWidget {
  /// The index of the currently selected destination.
  final int currentIndex;
  /// The callback that is called when a destination is tapped.
  final Function(int) onTap;

  /// Creates an [ISNavBar] widget.
  ///
  /// The [onTap] callback is required.
  const ISNavBar({
    super.key,
    this.currentIndex = 0,
    required this.onTap,
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
      labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>((states) {
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

class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({
    required this.navigationShell,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: ISNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }
}

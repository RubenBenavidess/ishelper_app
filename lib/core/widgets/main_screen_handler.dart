import 'package:flutter/material.dart';
import 'package:ishelper_app/core/widgets/home_screen.dart';
import 'package:ishelper_app/core/widgets/is_navigation_bar.dart';

class MainScreenHandler extends StatefulWidget {
  const MainScreenHandler({super.key});

  @override
  State<MainScreenHandler> createState() => _MainScreenHandlerState();
}

class _MainScreenHandlerState extends State<MainScreenHandler> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const Center(child: HomeScreen()),      // Index 0
    const Center(child: Text('Pantalla Soluciones')),// Index 1
    const Center(child: Text('Pantalla Contacto')),  // Index 2
    const Center(child: Text('Pantalla Soporte')),   // Index 3
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: ISNavBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishelper_app/src/view/screens/contact_screen.dart';
import 'package:ishelper_app/src/view/screens/home_screen.dart';
import 'package:ishelper_app/config/widgets/navigation_bar.dart';
import 'package:ishelper_app/src/viewmodel/cubits/contact_cubit.dart';

/// A stateful widget that manages the main screen, handling page navigation
/// via a bottom navigation bar.
class MainScreenHandler extends StatefulWidget {
  /// Creates a [MainScreenHandler] widget.
  const MainScreenHandler({super.key});

  @override
  State<MainScreenHandler> createState() => _MainScreenHandlerState();
}

class _MainScreenHandlerState extends State<MainScreenHandler> {
  int _currentIndex = 0;

  /// The list of pages to be displayed in the main content area.
  final List<Widget> _pages = [
    const Center(child: HomeScreen()), // Index 0: Home
    const Center(child: Text('Pantalla Soluciones')), // Index 1: Solutions
    BlocProvider(
      create: (_) => ContactCubit(),
      child: const ContactScreen(),
    ),   // Index 2: Contact
    const Center(child: Text('Pantalla Soporte')),    // Index 3: Support
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      _pages[_currentIndex],
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

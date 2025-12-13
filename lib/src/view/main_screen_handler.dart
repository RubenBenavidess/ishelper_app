import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishelper_app/src/services/file_input_service_impl.dart';
import 'package:ishelper_app/src/view/screens/contact_screen.dart';
import 'package:ishelper_app/src/view/screens/home_screen.dart';
import 'package:ishelper_app/config/widgets/navigation_bar.dart';
import 'package:ishelper_app/src/view/screens/pdf_screen.dart';
import 'package:ishelper_app/src/view/screens/solutions_screen.dart';
import 'package:ishelper_app/src/view/screens/support_screen.dart';
import 'package:ishelper_app/src/viewmodel/cubits/contact_cubit.dart';
import 'package:ishelper_app/src/viewmodel/cubits/file_cubit.dart';
import 'package:ishelper_app/src/viewmodel/cubits/navigation_index_cubit.dart';

/// A stateful widget that manages the main screen, handling page navigation
/// via a bottom navigation bar.

class MainScreenHandler extends StatelessWidget{

  static final List<Widget> _pages = [
    const Center(child: HomeScreen()),        // Index 0: Home
    const Center(child: SolutionsScreen()),   // Index 1: Solutions
    BlocProvider(                             // Index 2: Contact
      create: (_) => ContactCubit(),
      child: const ContactScreen(),
    ),   
    const Center(child: SupportScreen()),     // Index 3: Support
    BlocProvider(
      create: (_) => FileCubit(fileInputService: PDFFileInputService()),
      child: const PDFScreen(),
    )
  ];

  const MainScreenHandler({super.key});

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<NavigationIndexCubit, int>(
      builder: (context, state){
        return Scaffold(
          body:
            _pages[state],
          bottomNavigationBar: ISNavBar(
            currentIndex: state,
            onTap: (int index) {
              context.read<NavigationIndexCubit>().indexChanged(index);
            },
          ),
        );
      },
      buildWhen: (previous, current) => previous != current,
    );
    
  }


}

// class MainScreenHandler extends StatefulWidget {
//   /// Creates a [MainScreenHandler] widget.
//   const MainScreenHandler({super.key});

//   @override
//   State<MainScreenHandler> createState() => _MainScreenHandlerState();
// }

// class _MainScreenHandlerState extends State<MainScreenHandler> {
//   int _currentIndex = 0;

//   /// The list of pages to be displayed in the main content area.
//   final List<Widget> _pages = [
//     const Center(child: HomeScreen()), // Index 0: Home
//     const Center(child: SolutionsScreen()), // Index 1: Solutions
//     BlocProvider(
//       create: (_) => ContactCubit(),
//       child: const ContactScreen(),
//     ),   // Index 2: Contact
//     const Center(child: Text('Pantalla Soporte')),    // Index 3: Support
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:
//       _pages[_currentIndex],
//       bottomNavigationBar: ISNavBar(
//         currentIndex: _currentIndex,
//         onTap: (int index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//       ),
//     );
//   }
// }

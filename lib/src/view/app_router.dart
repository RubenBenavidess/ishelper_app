import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:ishelper_app/config/widgets/navigation_bar.dart';
import 'package:ishelper_app/src/view/screens/contact_screen.dart';
import 'package:ishelper_app/src/view/screens/home_screen.dart';
import 'package:ishelper_app/src/view/screens/pdf_screen.dart';
import 'package:ishelper_app/src/view/screens/solutions_screen.dart';
import 'package:ishelper_app/src/view/screens/support_screen.dart';

/// Global navigator key for root-level navigation.
///
/// Used by [GoRouter] to manage back button behavior and
/// navigate to modal routes that should not be part of the bottom navigation.
final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// The main router configuration for the ISHelper application.
///
/// Configures a bottom navigation based app with 4 main screens:
/// - Home (/home): Main entry point
/// - Solutions (/solutions): Solutions showcase
/// - Contact (/contact): Contact form for inquiries
/// - Support (/support): Support information
///
/// Additionally provides access to the PDF viewer (/pdf-viewer) as a modal route.
///
/// Uses [StatefulShellRoute] with [StatefulShellBranch] to maintain
/// state across navigation between bottom bar items, ensuring that
/// each screen maintains its own navigation stack.
final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: [
    /// Main shell with bottom navigation bar.
    ///
    /// This route maintains state for all bottom navigation branches.
    /// Each branch is independent and maintains its own navigation history.
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: [
        /// Home Screen Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        /// Solutions Screen Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/solutions',
              builder: (context, state) => const SolutionsScreen(),
            ),
          ],
        ),
        /// Contact Screen Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/contact',
              builder: (context, state) => const ContactScreen(),
            ),
          ],
        ),
        /// Support Screen Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/support',
              builder: (context, state) => const SupportScreen(),
            ),
          ],
        ),
      ],
    ),
    /// PDF Viewer Modal Route
    ///
    /// Opens the PDF viewer as a modal dialog/screen.
    /// This route is outside the bottom navigation stack.
    GoRoute(
      path: '/pdf-viewer',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        return PDFScreen();
      },
    ),
  ],
);
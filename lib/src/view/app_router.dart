import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:ishelper_app/config/widgets/navigation_bar.dart';
import 'package:ishelper_app/src/view/screens/contact_screen.dart';
import 'package:ishelper_app/src/view/screens/home_screen.dart';
import 'package:ishelper_app/src/view/screens/pdf_screen.dart';
import 'package:ishelper_app/src/view/screens/solutions_screen.dart';
import 'package:ishelper_app/src/view/screens/support_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/solutions',
              builder: (context, state) => const SolutionsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/contact',
              builder: (context, state) => const ContactScreen(),
            ),
          ],
        ),
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
    GoRoute(
      path: '/pdf-viewer',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        return PDFScreen();
      },
    ),
  ],
);
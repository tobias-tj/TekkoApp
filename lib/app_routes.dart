import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tekko/screens/accounts/create_account_screen.dart';
import 'package:tekko/screens/calendar/calendar_screen.dart';
import 'package:tekko/screens/favorites/favorite_screen.dart';
import 'package:tekko/screens/home_screen.dart';
import 'package:tekko/screens/notifications/notification_screen.dart';
import 'package:tekko/screens/settings/setting_screen.dart';
import 'package:tekko/components/navigation_wrapper.dart';
import 'package:tekko/screens/splash_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          body: child, // Pantalla actual
          bottomNavigationBar: const NavigationWrapper(), // Barra de navegación
        );
      },
      routes: [
        GoRoute(
          name: 'splash',
          path: '/splash',
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          name: 'create-account',
          path: '/create-account',
          builder: (context, state) => const CreateAccountScreen(),
        ),
        GoRoute(
          name: 'home',
          path: '/home',
          pageBuilder: (context, state) => NoTransitionPage(
            child: const HomePage(),
          ),
        ),
        GoRoute(
          name: 'calendar',
          path: '/calendar',
          pageBuilder: (context, state) => NoTransitionPage(
            child: const CalendarScreen(),
          ),
        ),
        GoRoute(
          name: 'favorites',
          path: '/favorites',
          pageBuilder: (context, state) => NoTransitionPage(
            child: const FavoriteScreen(),
          ),
        ),
        GoRoute(
          name: 'notifications',
          path: '/notifications',
          pageBuilder: (context, state) => NoTransitionPage(
            child: const NotificationScreen(),
          ),
        ),
        GoRoute(
          name: 'settings',
          path: '/settings',
          pageBuilder: (context, state) => NoTransitionPage(
            child: const SettingScreen(),
          ),
        ),
      ],
    ),
  ],
);

/// Clase personalizada para eliminar animaciones de transición
class NoTransitionPage extends CustomTransitionPage {
  NoTransitionPage({required Widget child})
      : super(
          child: child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child; // Sin animación, directamente devuelve el child
          },
        );
}

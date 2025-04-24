import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tekko/components/admin/navigation_admin_wrapper.dart';
import 'package:tekko/features/api/data/models/details_profile_dto.dart';
import 'package:tekko/screens/accounts/create_account_screen.dart';
import 'package:tekko/screens/accounts/login_account_screen.dart';
import 'package:tekko/screens/accounts/register_account_screen.dart';
import 'package:tekko/screens/activity/activity_screen.dart';
import 'package:tekko/screens/games/answer_task_screen.dart';
import 'package:tekko/screens/games/manage_task_screen.dart';
import 'package:tekko/screens/games/create_task_screen.dart';
import 'package:tekko/screens/games/task_screen.dart';
import 'package:tekko/screens/parent/create_activity_screen.dart';
import 'package:tekko/screens/calendar/calendar_screen.dart';
import 'package:tekko/screens/calendar/level_up_screen.dart';
import 'package:tekko/screens/calendar/winner_screen.dart';
import 'package:tekko/screens/favorites/favorite_screen.dart';
import 'package:tekko/screens/games/drawing_screen.dart';
import 'package:tekko/screens/games/memory_screen.dart';
import 'package:tekko/screens/home_screen.dart';
import 'package:tekko/screens/parent/admin_help_screen.dart';
import 'package:tekko/screens/parent/admin_home_screen.dart';
import 'package:tekko/screens/parent/admin_setting_screen.dart';
import 'package:tekko/screens/settings/credit_screen.dart';
import 'package:tekko/screens/settings/more_info_screen.dart';
import 'package:tekko/screens/parent/parent_pin_screen.dart';
import 'package:tekko/screens/settings/profile_summary_screen.dart';
import 'package:tekko/screens/settings/setting_screen.dart';
import 'package:tekko/components/navigation_wrapper.dart';
import 'package:tekko/screens/settings/update_pin_screen.dart';
import 'package:tekko/screens/splash_screen.dart';
import 'package:tekko/screens/welcome/welcome_screen.dart';
import 'package:tekko/screens/words/word_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      name: 'splash',
      path: '/splash',
      builder: (context, state) {
        final mode = state.uri.queryParameters['mode'];
        return SplashScreen(mode: mode);
      },
    ),
    GoRoute(
        name: 'welcome',
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen()),
    GoRoute(
      name: 'create-account',
      path: '/create-account',
      builder: (context, state) => const CreateAccountScreen(),
    ),
    GoRoute(
      name: 'register',
      path: '/register',
      builder: (context, state) => const RegisterAccount(),
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => const LoginAccount(),
    ),
    GoRoute(
      name: 'word-screen',
      path: '/word-screen/:id/:title',
      builder: (context, state) {
        final title = state.pathParameters['title'] ?? 'Sin título';
        final id = int.tryParse(state.pathParameters['id'] ?? '') ??
            0; // Convertir ID a entero
        return WordScreen(id: id, textTitle: title);
      },
    ),
    GoRoute(
      name: 'drawing',
      path: '/drawing',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: const DrawingScreen()),
    ),
    GoRoute(
      name: 'memory',
      path: '/memory',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: const MemoryScreen()),
    ),
    GoRoute(
        name: 'createTask',
        path: '/createTask',
        pageBuilder: (context, state) =>
            NoTransitionPage(child: const CreateTaskScreen())),
    GoRoute(
        name: 'tasks',
        path: '/tasks',
        pageBuilder: (context, state) =>
            NoTransitionPage(child: const TasksScreen())),
    GoRoute(
        name: 'answerTask',
        path: '/answerTask',
        pageBuilder: (context, state) {
          final task = (state.extra! as Map<String, dynamic>)['task'];
          return NoTransitionPage(child: AnswerTaskScreen(task: task));
        }),
    GoRoute(
      name: 'activity',
      path: '/activity',
      builder: (context, state) => const ActivityScreen(),
    ),
    GoRoute(
      name: 'winner',
      path: '/winner',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: const WinnerScreen()),
    ),
    GoRoute(
      name: 'levelUp',
      path: '/levelUp',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: const LevelUpScreen()),
    ),
    GoRoute(
        name: 'createActivity',
        path: '/createActivity',
        pageBuilder: (context, status) =>
            NoTransitionPage(child: const CreateActivityScreen())),
    GoRoute(
        name: 'profileDetails',
        path: '/profileDetails',
        pageBuilder: (context, state) {
          final profile = state.extra as DetailsProfileDto;
          return NoTransitionPage(
              child: ProfileSummaryScreen(profile: profile));
        }),
    GoRoute(
        name: 'updatePin',
        path: '/updatePin',
        pageBuilder: (context, status) =>
            NoTransitionPage(child: const UpdatePinScreen())),
    GoRoute(
        name: 'moreInformation',
        path: '/moreInformation',
        pageBuilder: (context, status) =>
            NoTransitionPage(child: const MoreInfoScreen())),
    GoRoute(
        name: 'creditInformation',
        path: '/creditInformation',
        pageBuilder: (context, status) =>
            NoTransitionPage(child: const CreditsScreen())),
    ShellRoute(
        builder: (context, state, child) {
          return Scaffold(
            body: child,
            bottomNavigationBar: const NavigationAdminWrapper(),
          );
        },
        routes: [
          GoRoute(
            name: 'adminHome',
            path: '/adminHome',
            pageBuilder: (context, state) => NoTransitionPage(
              child: const AdminHomeScreen(),
            ),
          ),
          GoRoute(
            name: 'adminTask',
            path: '/adminTask',
            pageBuilder: (context, state) =>
                NoTransitionPage(child: const ManageTaskScreen()),
          ),
          GoRoute(
            name: 'adminHelp',
            path: '/adminHelp',
            pageBuilder: (context, state) => NoTransitionPage(
              child: const AdminHelpScreen(),
            ),
          ),
          GoRoute(
            name: 'adminSettings',
            path: '/adminSettings',
            pageBuilder: (context, state) => NoTransitionPage(
              child: const AdminSettingScreen(),
            ),
          ),
        ]),
    GoRoute(
      name: 'parentModePin',
      path: '/parentModePin',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: const ParentPinScreen()),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          body: child, // Pantalla actual
          bottomNavigationBar: const NavigationWrapper(), // Barra de navegación
        );
      },
      routes: [
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

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tekko/styles/app_colors.dart';
import 'package:hugeicons/hugeicons.dart';

class NavigationAdminWrapper extends StatelessWidget {
  const NavigationAdminWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener el nombre de la ruta actual
    final currentRouteName =
        GoRouter.of(context).routeInformationProvider.value.location;

    // Mapa de nombres de rutas e índices
    final Map<String, int> routesIndex = {
      '/adminHome': 0,
      '/adminTask': 1,
      '/adminHelp': 2,
      '/adminSettings': 3,
    };

    // Obtener el índice correspondiente al nombre de la ruta actual
    final currentIndex = routesIndex[currentRouteName] ?? 0;

    return CurvedNavigationBar(
      backgroundColor: AppColors.softCream,
      color: AppColors.softCreamDark,
      buttonBackgroundColor: Colors.white,
      animationDuration: const Duration(milliseconds: 300),
      index: currentIndex, // Índice de la ruta actual
      items: [
        const HugeIcon(
          icon: HugeIcons.strokeRoundedHome01,
          color: AppColors.chocolateNewDark,
          size: 27.0,
        ),
        const HugeIcon(
          icon: HugeIcons.strokeRoundedMath,
          color: AppColors.chocolateNewDark,
          size: 27.0,
        ),
        HugeIcon(
            icon: HugeIcons.strokeRoundedHealtcare,
            color: AppColors.chocolateNewDark,
            size: 27.0),
        HugeIcon(
            icon: HugeIcons.strokeRoundedSettings01,
            color: AppColors.chocolateNewDark,
            size: 27.0),
      ],
      onTap: (index) {
        // Lista de rutas por índice
        final routes = routesIndex.keys.toList();
        context.go(routes[index]); // Navegar a la ruta correspondiente
      },
    );
  }
}

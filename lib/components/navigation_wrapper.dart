import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:tekko/styles/app_colors.dart';

class NavigationWrapper extends StatelessWidget {
  const NavigationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener el nombre de la ruta actual
    final currentRouteName =
        GoRouter.of(context).routeInformationProvider.value.location;

    // Mapa de nombres de rutas e índices
    final Map<String, int> routesIndex = {
      '/home': 0,
      '/calendar': 1,
      '/mapsInformation': 2,
      '/favorites': 3,
      '/settings': 4,
    };

    // Obtener el índice correspondiente al nombre de la ruta actual
    final currentIndex = routesIndex[currentRouteName] ?? 0;

    return CurvedNavigationBar(
      backgroundColor: AppColors.softCream,
      color: AppColors.softCreamDark,
      buttonBackgroundColor: Colors.white,
      animationDuration: const Duration(milliseconds: 300),
      index: currentIndex, // Índice de la ruta actual
      items: const [
        HugeIcon(
          icon: HugeIcons.strokeRoundedHome01,
          color: AppColors.chocolateNewDark,
          size: 27.0,
        ),
        HugeIcon(
          icon: HugeIcons.strokeRoundedCalendarFavorite02,
          color: AppColors.chocolateNewDark,
          size: 27.0,
        ),
        HugeIcon(
            icon: HugeIcons.strokeRoundedMapsGlobal01,
            color: AppColors.chocolateNewDark,
            size: 27.0),
        HugeIcon(
          icon: HugeIcons.strokeRoundedFavourite,
          color: AppColors.chocolateNewDark,
          size: 27.0,
        ),
        HugeIcon(
            icon: HugeIcons.strokeRoundedSettings01,
            color: AppColors.chocolateNewDark,
            size: 27.0)
      ],
      onTap: (index) {
        // Lista de rutas por índice
        final routes = routesIndex.keys.toList();
        context.go(routes[index]); // Navegar a la ruta correspondiente
      },
    );
  }
}

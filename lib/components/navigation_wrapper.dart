import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:tekko/styles/app_colors.dart';

class NavigationWrapper extends StatefulWidget {
  const NavigationWrapper({super.key});

  @override
  State<NavigationWrapper> createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  late GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = GoRouter.of(context);

    // Escuchar los cambios de ruta y actualizar el estado
    _router.routeInformationProvider.addListener(_onRouteChanged);
  }

  void _onRouteChanged() {
    // Forzar rebuild cuando cambia la ruta
    setState(() {});
  }

  @override
  void dispose() {
    _router.routeInformationProvider.removeListener(_onRouteChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentRouteName = _router.routeInformationProvider.value.location;

    final Map<String, int> routesIndex = {
      '/home': 0,
      '/calendar': 1,
      '/mapsInformation': 2,
      '/favorites': 3,
      '/settings': 4,
    };

    final currentIndex = routesIndex[currentRouteName] ?? 0;

    return SafeArea(
      top: false,
      child: CurvedNavigationBar(
        backgroundColor: AppColors.softCream,
        color: AppColors.softCreamDark,
        buttonBackgroundColor: Colors.white,
        animationDuration: const Duration(milliseconds: 300),
        index: currentIndex,
        items: const [
          HugeIcon(
              icon: HugeIcons.strokeRoundedHome01,
              color: AppColors.chocolateNewDark,
              size: 27.0),
          HugeIcon(
              icon: HugeIcons.strokeRoundedCalendarFavorite02,
              color: AppColors.chocolateNewDark,
              size: 27.0),
          HugeIcon(
              icon: HugeIcons.strokeRoundedMapsGlobal01,
              color: AppColors.chocolateNewDark,
              size: 27.0),
          HugeIcon(
              icon: HugeIcons.strokeRoundedFavourite,
              color: AppColors.chocolateNewDark,
              size: 27.0),
          HugeIcon(
              icon: HugeIcons.strokeRoundedSettings01,
              color: AppColors.chocolateNewDark,
              size: 27.0),
        ],
        onTap: (index) {
          final routes = routesIndex.keys.toList();
          context.go(routes[index]);
        },
      ),
    );
  }
}

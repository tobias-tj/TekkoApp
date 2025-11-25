import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:tekko/styles/app_colors.dart';

class NavigationWrapper extends StatelessWidget {
  const NavigationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRouteName =
        GoRouter.of(context).routeInformationProvider.value.location;

    final Map<String, int> routesIndex = {
      '/home': 0,
      '/calendar': 1,
      '/mapsInformation': 2,
      '/kidBooks': 3,
      '/favorites': 4,
      '/settings': 5,
    };

    final currentIndex = routesIndex[currentRouteName] ?? 0;

    return Container(
      color: AppColors.softCreamDark,
      child: SafeArea(
        top: false,
        bottom: true,
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
                icon: HugeIcons.strokeRoundedBookOpen02,
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
      ),
    );
  }
}

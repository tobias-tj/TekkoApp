import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tekko/components/dialog_home.dart';
import 'package:tekko/components/top_custom_background.dart';
import 'package:tekko/styles/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _navigationItem = [
    const Icon(Icons.home_outlined),
    const Icon(Icons.calendar_month_outlined),
    const Icon(Icons.favorite_border),
    const Icon(Icons.notifications_none),
    const Icon(Icons.settings_outlined)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.softCream,
        body: Column(
          children: [
            TopCustomBackground(title: "Hola Tobias!"),
            DialogHome(),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: AppColors.softCream,
          color: AppColors.softCreamDark,
          buttonBackgroundColor: Colors.white,
          animationDuration: const Duration(milliseconds: 300),
          index: 0,
          items: _navigationItem,
          onTap: (index) {
            if (index == 0) {
              print(
                  "Logica para ir a la pantalla de home que es en realidad en donde estamos actualmente");
            } else if (index == 1) {
              print("Logica para ir a la pantalla de calendario");
            } else if (index == 2) {
              print("logica para ir a la pantalla de favoritos");
            } else if (index == 3) {
              print("logica para ir a notificaciones");
            } else if (index == 4) {
              print("Logica para pantalla de settings");
            }
          },
        ));
  }
}
